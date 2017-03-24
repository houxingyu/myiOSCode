//
//  XYSearchViewController.m
//  searchTest
//
//  Created by houxingyu on 2017/3/22.
//  Copyright © 2017年 com.syt51.net.appstore.personal. All rights reserved.
//

#import "XYSearchViewController.h"
#import "XYSearchResultTableViewCell.h"

@interface XYSearchViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UISearchController *searchController;
@property (nonatomic, retain) NSMutableArray *arrOfSeachBoxes;/**< 搜索范围 */
@property (nonatomic, retain) NSMutableArray *arrOfSeachResults;/**< 搜索结果 */
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation XYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    //将SearchBar放在tableView的头部视图
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 获取关键字
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
    
    // 用关键字过滤数组中的内容, 将过滤后的内容放入结果数组
    self.arrOfSeachResults = [[self.arrOfSeachBoxes filteredArrayUsingPredicate:predicate] mutableCopy];
    
    // 完成数据的过滤和存储后刷新tableView.
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 显示搜索结果时
    if (self.searchController.active) {
        
        //以搜索结果的个数返回行数
        return self.arrOfSeachResults.count;
    }
    //没有搜索时显示所有数据
    return self.arrOfSeachBoxes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResult"];

    // 显示搜索结果时
    if (self.searchController.active) {
        
        // 原始搜索结果字符串.
        NSString *originResult = self.arrOfSeachResults[indexPath.row][@"name"];
        
        // 获取关键字的位置
        NSRange range = [originResult rangeOfString:self.searchController.searchBar.text];
        
        // 转换成可以操作的字符串类型.
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:originResult];
        
        // 添加属性(粗体)
        [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
        
        // 关键字高亮
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        // 将带属性的字符串添加到cell.textLabel上.
        [cell.infoLab setAttributedText:attribute];
        
    } else {
        cell.infoLab.text = self.arrOfSeachBoxes[indexPath.row][@"name"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 ;
}

- (NSMutableArray *)arrOfSeachBoxes{
    if (!_arrOfSeachBoxes) {
        _arrOfSeachBoxes=[@[
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
    return _arrOfSeachBoxes;
}

- (NSMutableArray *)arrOfSeachResults
{
    if (!_arrOfSeachResults) {
        _arrOfSeachResults = [NSMutableArray array];
    }
    return _arrOfSeachResults;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        // tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"XYSearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchResult"];
    }
    return _tableView;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        //searchBar的frame
        _searchController.searchBar.frame = CGRectMake(0, 44, 0, 44);
        
        // 是否需要在输入搜索内容时变暗
        _searchController.dimsBackgroundDuringPresentation = false;
        _searchController.searchBar.showsCancelButton = YES;/**< 取消按钮 */
        _searchController.searchResultsUpdater = self;/**< 显示搜索结果的VC */
        _searchController.active = YES;/**< 搜索结果显示 */
    }
    return _searchController;
}
@end
