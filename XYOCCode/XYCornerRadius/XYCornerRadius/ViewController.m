//
//  ViewController.m
//  XYCornerRadius
//
//  Created by houxingyu on 2017/3/23.
//  Copyright © 2017年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+circle.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIImage *image = [[UIImage imageNamed:@"callAd-03.jpg"] circleImage];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"callAd-03" ofType:@"jpg"];
    UIImage *thumbnail = [UIImage imageWithContentsOfFile:path];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //self.imageView.backgroundColor = [UIColor redColor];
    [self.imageView setImage:image];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
