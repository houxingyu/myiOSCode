//
//  Travel.h
//  learnFMDB
//
//  Created by houxingyu on 2016/12/29.
//  Copyright © 2016年 com.syt51.net.appstore.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Travel : NSObject

@property (nonatomic, copy) NSString *own_id;
@property (nonatomic, copy) NSString *travel_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *totalDic;

@end
