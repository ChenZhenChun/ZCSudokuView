//
//  IJShareView.h
//  AiyoyouDemo
//
//  Created by aiyoyou on 16/8/26.
//  Copyright © 2016年 aiyoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCSudokuView.h"
#import "ZCSudokuCell.h"

@interface IJShareView : UIView
//get后需要设置delegate和number属性，然后调用reloadData方法
@property (nonatomic,readonly) ZCSudokuView     *sudokuView;
@property (nonatomic,readonly) UIButton           *titleBtn;
@property (nonatomic,readonly) UIButton           *cancelBtn;

//显示菜单
- (void)showWithDuration:(NSTimeInterval)duration animations:(BOOL)animations;

//隐藏菜单
- (void)hiddenWithDuration:(NSTimeInterval)duration animations:(BOOL)animations;
@end
