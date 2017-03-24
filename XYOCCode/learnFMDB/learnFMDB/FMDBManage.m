//
//  FMDBManage.m
//  learnFMDB
//
//  Created by houxingyu on 2016/12/29.
//  Copyright © 2016年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "FMDBManage.h"
#import "FMDatabase.h"
#import "User.h"
#import "Travel.h"
#import "FMDatabaseQueue.h"

@interface FMDBManage()

@property (strong,nonatomic)FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation FMDBManage

+ (FMDBManage*)sharedFMDBManage
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[FMDBManage alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createFMDB];
    }
    return self;
}

- (void)createFMDB
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"test.sqlite"];
    NSLog(@"数据库地址：%@",filePath);
    self.db = [FMDatabase databaseWithPath:filePath];
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [self createTable];
}

- (void)createTable
{
    if ([self.db open]) {
        NSString *userSql = @"CREATE TABLE IF NOT EXISTS 'user' (user_phone test primary key,user_id test,user_sex test,time test)";
        NSString *travelSql = @"CREATE TABLE IF NOT EXISTS 'travel' (travel_id test primary key,own_id test,title test,date test)";
        if (![self.db executeUpdate:userSql]) {
            NSLog(@"创建表失败");
        }
        if (![self.db executeUpdate:travelSql]) {
            NSLog(@"创建表失败");
        }
        [self.db close];
    }
}

//插入数据，如果表中已有则执行更新操作(线程安全)
- (void)saveUserWithQueue:(User *)user
{
    dispatch_queue_t q1 = dispatch_queue_create("saveUser", NULL);
    
    dispatch_async(q1, ^{
        [self.queue inDatabase:^(FMDatabase *db) {
            [self.db open];
            BOOL insert = [self.db executeUpdate:@"INSERT INTO user(user_phone,user_id,user_sex)VALUES(?,?,?)",user.phone,user.ID,user.sex];
            if (!insert) {
                //执行更新操作
                NSLog(@"执行更新操作");
            }
            [self.db close];
        }];
    });
}

//线程不安全
- (void)saveUser:(User *)user
{
    if ([self.db open]) {
        BOOL insert = [self.db executeUpdate:@"INSERT INTO user(user_phone,user_id,user_sex,time)VALUES(?,?,?,?)",user.phone,user.ID,user.sex,[self currentTime]];
        if (!insert) {
            //执行更新操作
            NSLog(@"执行更新操作");
            [self updateUser:user];
        }
        [self.db close];
    }
}

//更新数据，(线程安全)
- (void)updateUserWithQueue:(User *)user
{
    dispatch_queue_t q1 = dispatch_queue_create("updateUser", NULL);
    
    dispatch_async(q1, ^{
        [self.queue inDatabase:^(FMDatabase *db) {
            [self.db open];
            [self.db executeUpdate:@"UPDATE 'user' SET user_id = ?  WHERE user_phone = ? ",user.ID,user.phone];
            [self.db executeUpdate:@"UPDATE 'user' SET user_sex = ?  WHERE user_phone = ? ",user.sex,user.phone];
            [self.db close];
        }];
    });
}

//更新数据，(线程不安全)
- (void)updateUser:(User *)user
{
    if ([self.db open]) {
        [self.db executeUpdate:@"UPDATE 'user' SET user_id = ?, user_sex = ?,time = ?  WHERE user_phone = ? ",user.ID,user.sex,[self currentTime],user.phone];
        [self.db close];
    }
}

//查询所有user数据，按照某一个字段降序排列（默认是升序小到大）
- (NSMutableArray *)getAllUserOrderByTime
{
    NSMutableArray *userArr = [[NSMutableArray alloc]init];
    if ([self.db open]) {
        FMResultSet *result = [self.db executeQuery:@"select * from user order by time desc"];
        
        while ([result next]) {
            User *user = [[User alloc]init];
            user.ID = [result stringForColumn:@"user_id"];
            user.phone = [result stringForColumn:@"user_phone"];
            user.sex = [result stringForColumn:@"user_sex"];
            user.lastLogintime = [result stringForColumn:@"time"];
            [userArr addObject:user];
        }
        [self.db close];
    }
    return userArr;
}

//根据手机号，查询用户表中的对应数据
- (void)getUserFromPhone:(NSString *)phone
{
    if ([self.db open]) {
        //注意问好只能是英文状态下的
        FMResultSet *result = [self.db executeQuery:@"select * from user where user_phone = ?",phone];
        while ([result next]) {
            User *user = [[User alloc]init];
            user.ID = [result stringForColumn:@"user_id"];
            user.phone = [result stringForColumn:@"user_phone"];
            user.sex = [result stringForColumn:@"user_sex"];
            user.lastLogintime = [result stringForColumn:@"time"];
            NSLog(@"user:%@",user);
        }
        [self.db close];
    }
}

//给当前登录用户添加行程
- (void)saveTravel:(Travel *)travel toUser:(NSString *)phone
{
    if ([self.db open]) {
        
        [self.db executeUpdate:@"INSERT INTO travel(travel_id,own_id,title,date)VALUES(?,?,?,?)",travel.travel_id,phone,travel.title,[self baseDecodeWithDic:travel.totalDic]];
        
        [self.db close];
    }
}

//查询当前登录用户的行程
- (void)getTravelAt:(NSString *)travelID fromUser:(NSString *)phone
{
    if ([self.db open]) {
        FMResultSet *result = [self.db executeQuery:@"select * from travel where own_id = ?",phone];
        while ([result next]) {
            Travel *travel = [[Travel alloc]init];
            travel.travel_id = [result stringForColumn:@"travel_id"];
            travel.own_id = [result stringForColumn:@"own_id"];
            travel.title = [result stringForColumn:@"title"];
            NSString *strData = [result stringForColumn:@"date"];
            travel.totalDic = [self baseEncodeWithString:strData];
            NSLog(@"travel:%@",travel);
        }
        
        [self.db close];
    }
}

//删除某一个用户的所有行程
- (void)deleteAllTravelFromUser:(NSString *)phone
{
    if ([self.db open]) {
        [self.db executeUpdate:@"DELETE FROM travel WHERE own_id = ?",phone];
        [self.db close];
    }
}

//删除某一个用户
- (void)deleteUserWithPhone:(NSString *)phone
{
    if ([self.db open]) {
        
        [_db executeUpdate:@"DELETE FROM user WHERE user_phone = ?",phone];
        [self.db close];
    }
}

- (NSString *)currentTime
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    return currentTime;
}

//字典编码
- (NSString *)baseDecodeWithDic:(NSMutableArray *)dic{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return  str;
}

//字符串解码
- (NSMutableArray *)baseEncodeWithString:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return dic;
}
@end
