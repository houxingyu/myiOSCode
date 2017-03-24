//
//  FMDBManage.h
//  learnFMDB
//
//  Created by houxingyu on 2016/12/29.
//  Copyright © 2016年 com.syt51.net.appstore.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Travel;
@interface FMDBManage : NSObject

+ (FMDBManage*)sharedFMDBManage;
- (void)saveUser:(User *)user;
- (void)updateUser:(User *)user;
- (void)updateUserWithQueue:(User *)user;
- (NSMutableArray *)getAllUserOrderByTime;
- (void)getUserFromPhone:(NSString *)phone;
- (void)saveTravel:(Travel *)travel toUser:(NSString *)phone;
- (void)getTravelAt:(NSString *)travelID fromUser:(NSString *)phone;

@end
