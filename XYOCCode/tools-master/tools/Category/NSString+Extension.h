//
//  NSString+Extension.h
//  QQ聊天布局
//
//  Created by 侯兴宇 on 15/10/19.
//  Copyright © 2015年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

//通过字体和最大长度，返回CGSize
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
//通过字体，返回CGSize
- (CGSize)sizeWithFont:(UIFont *)font;
//当前时间
+ (NSString *)currentTime;
//字典编码
+ (NSString *)baseDecodeWithDic:(NSMutableArray *)arr;
//获取汉字转成拼音字符串  通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
+ (NSString *)transformToPinyin:(NSString *)aString;
@end
