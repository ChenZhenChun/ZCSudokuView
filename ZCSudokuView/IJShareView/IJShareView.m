//
//  IJShareView.m
//  AiyoyouDemo
//
//  Created by aiyoyou on 16/8/26.
//  Copyright © 2016年 aiyoyou. All rights reserved.
//

#import "IJShareView.h"

#define kContentViewH (352*_scale)
#define SVScreenHeight [[UIScreen mainScreen] bounds].size.height
#define SVScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface IJShareView()
{
    NSTimeInterval _durationTime;
    BOOL           _animations;
}
@property (nonatomic,assign) CGFloat         scale;//屏幕比例
@property (nonatomic,strong) UIView         *contentView;
@property (nonatomic,strong) ZCSudokuView   *sudokuViewTemp;
@property (nonatomic,strong) UIButton       *titleBtn;
@property (nonatomic,strong) UIButton       *cancelBtn;

@end

@implementation IJShareView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0,SVScreenHeight,SVScreenWidth,SVScreenHeight);
        self.backgroundColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:0.3];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelf)];
        [self addGestureRecognizer:tap];
        [self addSubview:self.contentView];
    }
    return self;
}

//contentView
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        [_contentView addSubview:self.titleBtn];
        [self.sudokuViewTemp showWithView:_contentView];
        [_contentView addSubview:self.cancelBtn];
        
        self.userInteractionEnabled = YES;
        _contentView.frame = CGRectMake(0,
                                        SVScreenHeight-kContentViewH,
                                        SVScreenWidth,
                                        kContentViewH);
        
    }
    return _contentView;
}

- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.backgroundColor = [UIColor whiteColor];
        [_titleBtn setTitle:@"分享到" forState:UIControlStateNormal];
        [_titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:16*_scale];
        _titleBtn.userInteractionEnabled = YES;
        _titleBtn.frame = CGRectMake(0,
                                       0,
                                       SVScreenWidth,
                                       44*_scale);
    }
    return _titleBtn;
}

- (ZCSudokuView *)sudokuViewTemp {
    if (!_sudokuViewTemp) {
        _sudokuViewTemp = [[ZCSudokuView alloc] init];
        _sudokuViewTemp.backgroundColor = [UIColor whiteColor];
        _sudokuViewTemp.columnAmount = 3;
        _sudokuViewTemp.rowAmount = 2;
        _sudokuViewTemp.layer.borderColor = [UIColor colorWithRed:207/255.0 green:210/255.0 blue:213/255.0 alpha:0.7].CGColor;
        _sudokuViewTemp.layer.borderWidth = 0.5;
        [_sudokuViewTemp showWithView:self.contentView];
        _sudokuViewTemp.frame = CGRectMake(0,
                                       44*_scale,
                                       SVScreenWidth,
                                       258*_scale);
        
    }
    return _sudokuViewTemp;
}

//UIButton
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:162/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16*_scale];
        _cancelBtn.userInteractionEnabled = NO;
        _cancelBtn.frame = CGRectMake(0,
                                   kContentViewH-50*_scale,
                                   SVScreenWidth,
                                   50*_scale);
    }
    return _cancelBtn;
}

- (ZCSudokuView *)sudokuView {
    return self.sudokuViewTemp;
}

#pragma mark - Action
//点击空白or取消按钮隐藏菜单
- (void)clickSelf {
    [self hiddenWithDuration:_durationTime animations:_animations];
}
//显示headView
- (void)showWithDuration:(NSTimeInterval)duration animations:(BOOL)animations {
    _durationTime = duration;
    _animations = animations;
    if (animations) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            [weakSelf bringSubviewToFront:weakSelf.superview];
            weakSelf.frame = [[UIScreen mainScreen]bounds];
        }];
    }else {
        [self bringSubviewToFront:self.superview];
        self.frame = [[UIScreen mainScreen]bounds];
    }
}
//隐藏headView
- (void)hiddenWithDuration:(NSTimeInterval)duration animations:(BOOL)animations {
    if (animations) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            [weakSelf sendSubviewToBack:weakSelf.superview];
            weakSelf.frame = CGRectMake(0,2*SVScreenHeight,SVScreenWidth,SVScreenHeight);
        }];
    }else {
        [self sendSubviewToBack:self.superview];
        self.frame = CGRectMake(0,2*SVScreenHeight,SVScreenWidth,SVScreenHeight);
    }
}

#pragma mark - Properties

- (CGFloat)scale {
    if (_scale == 0) {
        _scale = ([UIScreen mainScreen].bounds.size.height>480?[UIScreen mainScreen].bounds.size.height/667.0:0.851574);
    }
    return _scale;
}

@end
