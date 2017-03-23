//
//  ViewController.m
//  GraphicsPerformance
//
//  Created by houxingyu on 2017/3/23.
//  Copyright © 2017年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "ViewController.h"
#import "GraphicsPerformanceTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置不会导致图层混合
    //self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.opaque = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GraphicsPerformanceTableViewCell" bundle:nil] forCellReuseIdentifier:@"GraphicsPerformance"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GraphicsPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraphicsPerformance"];
    
    cell.infoLab.text = self.dataArr[indexPath.row][@"name"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 ;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[@[
                            @{@"portrait":@"1",@"name":@"1"},
                            @{@"portrait":@"2",@"name":@"1243546"},
                            @{@"portrait":@"3",@"name":@"东方不败"},
                            @{@"portrait":@"4",@"name":@"任我行"},
                            @{@"portrait":@"5",@"name":@"逍遥王"},
                            @{@"portrait":@"6",@"name":@"阿离"},
                            @{@"portrait":@"13",@"name":@"百草堂"},
                            @{@"portrait":@"8",@"name":@"三味书屋"},
                            @{@"portrait":@"9",@"name":@"彩彩"},
                            @{@"portrait":@"10",@"name":@"陈晨"},
                            @{@"portrait":@"11",@"name":@"多多"},
                            @{@"portrait":@"12",@"name":@"峨嵋山"},
                            @{@"portrait":@"7",@"name":@"哥哥"},
                            @{@"portrait":@"14",@"name":@"林俊杰"},
                            @{@"portrait":@"15",@"name":@"足球"},
                            @{@"portrait":@"16",@"name":@"58赶集"},
                            @{@"portrait":@"17",@"name":@"搜房网"},
                            @{@"portrait":@"18",@"name":@"欧弟"}
                            ]mutableCopy];
    }
    return _dataArr;
}
@end
