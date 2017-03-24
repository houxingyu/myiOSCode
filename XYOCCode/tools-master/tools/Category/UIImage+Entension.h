//
//  UIImage+Entension.h
//  QQ聊天布局
//
//  Created by 侯兴宇 on 15/10/19.
//  Copyright © 2015年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Entension)

//以中间为准，拉伸图片。节省空间
+ (UIImage *)resizableImageWithName:(NSString *)name;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
