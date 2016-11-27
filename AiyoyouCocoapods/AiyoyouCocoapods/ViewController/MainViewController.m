//
//  MainViewController.m
//  AiyoyouCocoapods
//
//  Created by aiyoyou on 2016/11/27.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "MainViewController.h"
#import "DataArray.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray         *_data;
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"首页";
    
    _data = [DataArray getDemoList];
    //ios7新特性，根据navigationbar与tabbar的高度，自动调整scrollview的inset，设置为no，让它不要自动调整。
    //self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.navigationController.navigationBar.translucent = NO;//关闭导航栏半透明效果。
    //修改下一个页面的返回按钮的title
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                  [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"demoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //添加cell右侧的小箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    //去掉选中cell时背景的高亮灰
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    long row = indexPath.row;
    cell.textLabel.text = [_data[row] objectForKey:@"demoName"];
    cell.detailTextLabel.text=[_data[row] objectForKey:@"controllerName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //页面跳转
    long row = indexPath.row;
    NSString *controllerName = [_data[row] objectForKey:@"controllerName"];
    Class _controllerClass = NSClassFromString(controllerName);
    UIViewController *_controllerView = [[_controllerClass alloc]init];
    [self.navigationController pushViewController:_controllerView animated:YES];
}
@end
