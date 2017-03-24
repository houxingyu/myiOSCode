//
//  ViewController.m
//  learnFMDB
//
//  Created by houxingyu on 2016/12/28.
//  Copyright © 2016年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManage.h"
#import "User.h"
#import "Travel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self saveUser];
    //[self uptateUser];
    //[self getUser];
    //[self getUserWithPhone];
    
    //[self saveTravel];
    [self getTravel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveTravel
{
    NSDictionary *dic = @{
                          @"a" : @"1",
                          @"b" : @"2"
                          
                          };
    
    Travel *travel = [[Travel alloc]init];
    travel.travel_id = @"2";
    travel.title = @"1";
    [travel.totalDic addObject:dic];
    [travel.totalDic addObject:dic];
    NSLog(@"travel:%@",travel.totalDic);
    [[FMDBManage sharedFMDBManage]saveTravel:travel toUser:@"18310849051"];
}

- (void)saveUser
{
    for (int i = 0; i < 3; i++) {
        User *user = [[User alloc]init];
        user.phone = [NSString stringWithFormat:@"1831084905%d",i];
        user.ID = [NSString stringWithFormat:@"%d",i];
        user.sex = @"女";
        [[FMDBManage sharedFMDBManage] saveUser:user];
    }
}

- (void)getTravel
{
    [[FMDBManage sharedFMDBManage]getTravelAt:nil fromUser:@"18310849051"];
}

- (void)uptateUser
{
        User *user = [[User alloc]init];
        user.phone = @"18310849051";
        user.ID = @"10";
        user.sex = @"男";
        [[FMDBManage sharedFMDBManage] updateUser:user];
}

- (void)getUser
{
    [[FMDBManage sharedFMDBManage] getAllUserOrderByTime];
}

- (void)getUserWithPhone
{
    [[FMDBManage sharedFMDBManage]getUserFromPhone:@"18310849051"];
}

@end
