//
//  SFBaseTableViewController.m
//  ShortCakeSFDoctor
//
//  Created by amu on 15/3/13.
//  Copyright (c) 2015年 zysoft. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
@property (nonatomic,strong) UISearchBar *searchBar;
/**
 *  判断tableView是否支持iOS7的api方法
 *
 *  @return 返回预想结果
 */
- (BOOL)validateSeparatorInset;


@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowSearchBar = NO;
    [self.view addSubview:self.tableView];
}


#pragma mark -init

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect tableViewFrame = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:self.tableViewStyle];
        [self configuraTableViewNormalSeparatorInset];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (![self validateSeparatorInset]) {
            if (self.tableViewStyle == UITableViewStyleGrouped) {
                UIView *backgroundView = [[UIView alloc] initWithFrame:_tableView.bounds];
                backgroundView.backgroundColor = _tableView.backgroundColor;
                _tableView.backgroundView = backgroundView;
            }
        }
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _tableView;
}

- (void)setIsShowSearchBar:(BOOL)isShowSearchBar {
    if (isShowSearchBar) {
        self.tableView.tableHeaderView = self.searchBar;
    }else {
        self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    }
    _isShowSearchBar = isShowSearchBar;
}
//搜索框
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 40)];
        _searchBar.placeholder=@"搜索";
        _searchBar.delegate = self;
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [UISearchBar setBackgroundForSearchBar:_searchBar withColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]];
    }
    return _searchBar;
}

- (UISearchBar *)baseSearchBar {
    return _searchBar;
}

//搜索所需要的数据源
- (NSMutableArray *)searchDataSource {
    if (!_searchDataSource) {
        _searchDataSource = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _searchDataSource;
}

//cell渲染所需要的数据源
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataSource;
}

- (NSArray *)viewConfig {
    if (!_viewConfig) {
        _viewConfig = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _viewConfig;
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


#pragma mark -UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark -UISearchBarDelegate
//搜索框值改变触发事件
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //子类重写
}


#pragma mark - action

- (void)configuraTableViewNormalSeparatorInset {
    //ios7分割线顶头
    if ([self validateSeparatorInset]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    //ios8分割线顶头
    if ([self validateLayoutMargins]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView {
    if ([tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
}

- (BOOL)validateSeparatorInset {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        return YES;
    }
    return NO;
}

- (BOOL)validateLayoutMargins {
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        return YES;
    }
    return NO;
}

- (void)xjErrorView {
    float y = (self.tableView.frame.size.height - self.tableView.tableHeaderView.frame.size.height)*0.4+self.tableView.tableHeaderView.frame.size.height;
    self.errorLabel.frame = CGRectMake(0,y,[UIScreen mainScreen].bounds.size.width, 30);
    [self.tableView addSubview:self.errorLabel];
}

- (void)xjErrorViewWithMessage:(NSString *) message {
    float y = (self.tableView.frame.size.height - self.tableView.tableHeaderView.frame.size.height)*0.4+self.tableView.tableHeaderView.frame.size.height;
    self.errorLabel.frame = CGRectMake(0,y,[UIScreen mainScreen].bounds.size.width, 30);
    self.errorLabel.text = message;
    [self.tableView addSubview:self.errorLabel];
}

- (void)xjErrorViewHide {
    [self.errorLabel removeFromSuperview];
}

- (void)loadDataSource {
    // subClasse
}

- (void)loadViewConfig {
    // subClasse
}

@end
