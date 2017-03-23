//
//  GraphicsPerformanceTableViewCell.m
//  GraphicsPerformance
//
//  Created by houxingyu on 2017/3/23.
//  Copyright © 2017年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "GraphicsPerformanceTableViewCell.h"

@implementation GraphicsPerformanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置lab的背景色为不透明的背景色则可以避免红色的出现，但是如果有中文还是会有图层混合的情况
    self.infoLab.backgroundColor = [UIColor whiteColor];
    //加上这个属性中文也不会有图层混合
    self.infoLab.layer.masksToBounds=YES;
    
    self.infoLab.layer.cornerRadius = 8;
    self.infoLab.layer.masksToBounds = YES;
    self.infoLab.layer.borderWidth = 1;
    self.infoLab.layer.borderColor = [UIColor blueColor].CGColor;
    self.infoLab.layer.shouldRasterize = YES;
    self.infoLab.layer.rasterizationScale = self.infoLab.layer.contentsScale;
/*
 * 将label的layer光栅化
 * 光栅化是将一个layer预先渲染成位图(bitmap)，然后加入缓存中。如果对于阴影效果这样比较消耗资源的静态内容进行缓存，可以得到一定幅度的性能提升
 * 但是会导致离屏渲染（建议不要使用）
 */
    //self.infoLab.layer.shouldRasterize = true;
    
    //设置符合尺寸的图片，这里为了对比可以使用test.jpg 可以有缩放的效果
    [self.iconImageView setImage:[UIImage imageNamed:@"test80*80"]];
    
    //设置阴影会导致离屏渲染
    self.iconImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.iconImageView.layer.shadowOpacity = 1;
    self.iconImageView.layer.shadowRadius = 2;
    self.iconImageView.layer.shadowOffset = CGSizeMake(1, 1);
    //添加这行代码就可以结局
    self.iconImageView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.iconImageView.bounds] CGPath];
 
    //不会触发离屏渲染
    self.btn.layer.cornerRadius = 8;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = [UIColor blueColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
