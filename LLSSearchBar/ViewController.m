//
//  ViewController.m
//  LLSSearchBar
//
//  Created by liulishuo on 2018/4/27.
//  Copyright © 2018 liulishuo. All rights reserved.
//

#import "ViewController.h"
#import "VKSearchBar.h"

@interface ViewController ()<VKSearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) VKSearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray *searchResultArray;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4"]];
    _searchResultArray = [NSMutableArray new];
    
    _searchBar = [VKSearchBar initWithDelegate:self];
    _searchBar.placeholder = @"231312312312312312312312312312312312312313哈数据大幅哈里斯点击返回拉萨开发";
    _searchBar.placeholderHorizontalMargin = 20;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Event Response
#pragma mark - Network
#pragma mark - Delegate
#pragma mark -- TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchBar.active) {
        return _searchResultArray.count;
    }
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    
    if (_searchBar.active) {
        cell.textLabel.text = _searchResultArray[indexPath.row];
    } else {
        cell.textLabel.text = _dataArray[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _searchBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _searchBar.bounds.size.height;
}

#pragma mark - VKSearchBar Delegate
- (void)vkSearchBarDidBeginEditing:(VKSearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)vkSearchBarCancelButtonClicked:(VKSearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)vkSearchBar:(VKSearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_searchResultArray removeAllObjects];
    //执行搜索操作
    [self filterContentForSearchText:searchText];
    //刷新表格
    [_tableView reloadData];
}

#pragma mark - Methods
- (void)filterContentForSearchText:(NSString*)searchText {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        NSString *storeString = _dataArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [tempResults addObject:self.dataArray[i]];
        }
    }
    [_searchResultArray removeAllObjects];
    [_searchResultArray addObjectsFromArray:tempResults];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
#pragma mark - Setter and Getter

@end
