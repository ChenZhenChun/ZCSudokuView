//
//  XJSearchBar.h
//  AiyoyouDemo
//
//  Created by aiyoyou on 16/9/23.
//  Copyright © 2016年 aiyoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCSudokuCell.h"
#import "ZCSudokuView.h"

@class XJSearchBar;


@protocol XJSearchBarDelegate <NSObject>
@required
- (void)XJSearchBar:(ZCSudokuCell *)sudokuCell cellForRowAtIndext:(NSInteger)index;
@optional
- (void)XJSearchBar:(ZCSudokuCell *)sudokuCell didSelectedCellWithIndex:(NSInteger)index;
- (void)XJSearchBarGoSearch:(XJSearchBar *)searchBar;//搜索按钮点击

@end

@interface XJSearchBar : UIView
@property (nonatomic,assign)    id<XJSearchBarDelegate>     delegate;
@property (nonatomic,assign)    NSInteger                   number;//总数
@property (nonatomic,copy)      NSString                    *title;
@property (nonatomic,readonly)  NSString                    *searchBarText;
@property (nonatomic,strong)    UIImage                     *placeholderImage;//放大镜图片
@property (nonatomic,strong)    UIButton                    *filterBtn;//筛选按钮
//- (void)showWithDuration:(NSTimeInterval)duration animations:(BOOL)animations;
//- (void)hiddenWithDuration:(NSTimeInterval)duration animations:(BOOL)animations;
@end
