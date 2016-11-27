//
//  SFBaseTableViewController.h
//  ShortCakeSFDoctor
//
//  Created by amu on 15/3/13.
//  Copyright (c) 2015年 zysoft. All rights reserved.
//
#import "UITableViewCell+Separator.h"
@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

/**
 *  显示大量数据的控件
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  初始化init的时候设置tableView的样式才有效
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/**
 *  是否带有搜索框，yes带搜索框，no不带搜索框。
 */
@property (nonatomic) BOOL isShowSearchBar;

/**
 *  搜索框（isShowSearchBar＝yes时，搜索框会自动被初始化）,供子类调用。
 */
@property (nonatomic,readonly) UISearchBar *baseSearchBar;

/**
 *  界面配置项
 */
@property (nonatomic, strong) NSArray *viewConfig;

/**
 *  cell渲染时需要的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  带搜索框时这个属性是最大的数据源，dataSource是搜索过滤后的数据源
 */
@property (nonatomic,strong) NSMutableArray *searchDataSource;


/**
 *  去除ios8、iOS7新的功能api，tableView的分割线变成iOS6正常的样式
 */
- (void)configuraTableViewNormalSeparatorInset;

/**
 *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

/**
 *  加载本地或者网络数据源
 */
- (void)loadDataSource;

/**
 *  加载界面配置
 */
- (void)loadViewConfig;



@end
