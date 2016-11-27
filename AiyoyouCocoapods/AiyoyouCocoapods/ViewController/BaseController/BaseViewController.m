//
//  BaseController.m
//  xjdoctor
//
//  Created by mySon on 15/12/24.
//  Copyright © 2015年 zoenet. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic)        CGRect          oldFrame;
@property (nonatomic,strong) UILabel         *tipTitle;
@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.leftBarButtonItem=self.leftBar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect frame = self.view.bounds;
    float adaptaHeight = (self.navigationController.viewControllers.count > 1) ? 64 : (49 + 64);
    self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height -adaptaHeight);
    frame.size.height -= adaptaHeight;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark -init

- (UILabel *)tipTitle {
    if (!_tipTitle) {
        _tipTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.3,[UIScreen mainScreen].bounds.size.width, 30)];
        _tipTitle.text = @"暂无相关数据";
        [_tipTitle setTextColor:[UIColor grayColor]];
        _tipTitle.backgroundColor = [UIColor clearColor];
        _tipTitle.font = [UIFont systemFontOfSize:15];
        _tipTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _tipTitle;
}

//该接口给外部掉用（只读接口）
- (UILabel *)errorLabel {
    return self.tipTitle;
}

//空页面对象
//- (EmptyPageDraw *)emptyPageDraw {
//    if (!_emptyPageDraw) {
//        _emptyPageDraw = [[EmptyPageDraw alloc]init];
//    }
//    return _emptyPageDraw;
//}

- (UIBarButtonItem *)leftBar {
    if (!_leftBar) {
        _leftBar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"go-back-icon"] style:UIBarButtonItemStyleDone target:self action:@selector(backOnView)];
    }
    return _leftBar;
}


#pragma mark -textFieldDelegate
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.oldFrame = self.view.frame;
    //获取textField在屏幕上的坐标
    CGPoint textFieldPoint = [[textField superview]convertPoint:textField.frame.origin toView:self.view.window];
    
    int offset = textFieldPoint.y + textField.frame.size.height - (self.view.frame.size.height-216.0)-[self navBarHeight]+30;//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = self.oldFrame;
}


#pragma mark -textViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.oldFrame = self.view.frame;
    //获取textField在屏幕上的坐标
    CGPoint textFieldPoint = [[textView superview]convertPoint:textView.frame.origin toView:self.view.window];
    int offset = textFieldPoint.y + textView.frame.size.height - (self.view.frame.size.height - 216.0)-[self navBarHeight]+50;//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.view.frame = self.oldFrame;
}


#pragma mark -action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)xjErrorView {
    [self.view addSubview:self.tipTitle];
}

- (void)xjErrorViewWithMessage:(NSString *) message {
    self.tipTitle.text = message;
    [self.view addSubview:self.tipTitle];
}

- (void)xjErrorViewHide {
    if (_tipTitle) {
        [_tipTitle removeFromSuperview];
    }
}

//导航栏是否被隐藏;隐藏的时候导航条高度为0，显示的时候导航条高度为64；
- (float)navBarHeight {
    if (self.navigationController.navigationBar.isHidden) {
        return 0;
    }
    return 64;
}

- (void)backOnView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count>1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
