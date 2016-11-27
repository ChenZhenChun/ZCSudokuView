//
//  BaseController.h
//  xjdoctor
//
//  Created by mySon on 15/12/24.
//  Copyright © 2015年 zoenet. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EmptyPageDraw.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong)    UIBarButtonItem     *leftBar;
@property (nonatomic,readonly)  UILabel             *errorLabel;
//@property (nonatomic,strong)    EmptyPageDraw       *emptyPageDraw;//空页面处理类

//页面中的空白文字提示
- (void)xjErrorView;
- (void)xjErrorViewWithMessage:(NSString *) message;
- (void)xjErrorViewHide;

/**
 返回
 */
- (void)backOnView;

@end
