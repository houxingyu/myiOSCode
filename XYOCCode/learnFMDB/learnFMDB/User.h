//
//  User.h
//  learnFMDB
//
//  Created by houxingyu on 2016/12/29.
//  Copyright © 2016年 com.syt51.net.appstore.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *lastLogintime;
@property (nonatomic, strong) NSMutableArray *travelArray;

@end
