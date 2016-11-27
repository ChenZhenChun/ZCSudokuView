//
//  SFMultipleSectionTableViewController.m
//  ShortCakeSFDoctor
//
//  Created by amu on 15/10/20.
//  Copyright (c) 2015年 zysoft. All rights reserved.
//

#import "MultipleSectionTableViewController.h"

@interface MultipleSectionTableViewController ()

@end

@implementation MultipleSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
}


#pragma mark -init

- (id)init {
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (NSMutableArray *)sectionIndexTitles{
    if(!_sectionIndexTitles){
        _sectionIndexTitles = [[NSMutableArray alloc] init];
    }
    return _sectionIndexTitles;
}

- (NSMutableArray *)sectionHeaderTitles{
    if(!_sectionHeaderTitles){
        _sectionHeaderTitles = [[NSMutableArray alloc] init];
    }
    return _sectionHeaderTitles;
}


#pragma mark - UITableViewDelegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.dataSource.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.dataSource[section] count];
//}

// table section设置
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.sectionHeaderTitles.count){
        return self.sectionHeaderTitles[section];
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.sectionHeaderTitles.count){
        UIView *customHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 22.0f)];
        customHeaderView.backgroundColor = [UIColor colorWithRed:0.926 green:0.920 blue:0.956 alpha:1.000];
        
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 0, CGRectGetWidth(customHeaderView.bounds) - 15.0f, 22.0f)];
        headerLabel.text = self.sectionHeaderTitles[section];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        headerLabel.textColor = [UIColor darkGrayColor];
        
        [customHeaderView addSubview:headerLabel];
        return customHeaderView;
    }else{
        return nil;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if(_showSectionIndexTitles){
        return self.sectionIndexTitles;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
