//
//  SystemPushManage.h
//  fireME
//
//  Created by houxingyu on 2017/7/12.
//  Copyright © 2017年 com.dongxun.xiaofang.appstore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SystemPushManage : NSObject

+ (SystemPushManage *)sharedSystemPushManage;

//通知注册
- (void)registerSystemPushWithApplication:(UIApplication *)application;

@end
