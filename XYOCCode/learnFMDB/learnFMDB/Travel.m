//
//  Travel.m
//  learnFMDB
//
//  Created by houxingyu on 2016/12/29.
//  Copyright © 2016年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "Travel.h"

@implementation Travel

- (NSMutableArray *)totalDic
{
    if (!_totalDic) {
        _totalDic = [NSMutableArray array];
    }
    return _totalDic;
}

@end
