/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#define CustomViewHeight 82
#define CustomViewWidth 80

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    //HUD.labelText = hint;
    hud.customView = [self gifImageView:hint];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor clearColor];
    
    [hud show:YES];
    [self setHUD:hud];
}

- (void)showHintTip:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }

    
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-happy.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = hint;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:3];
}

- (void)showHintError:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-sad.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = hint;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}



- (void)hideHud{
    [[self HUD] hide:YES];
}

- (void)hideHudAfterDelay:(NSTimeInterval)delay{
    [[self HUD] hide:YES afterDelay:delay];
}


-(UIImageView*)gifImageView:(NSString *)string{
    @autoreleasepool {
        UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CustomViewWidth, CustomViewHeight)];
        NSArray *gifArray = [NSArray arrayWithObjects:LOADIMAGE(@"loading1@2x", @"png"),
                             LOADIMAGE(@"loading2@2x", @"png"),
                             LOADIMAGE(@"loading3@2x", @"png"),
                             LOADIMAGE(@"loading4@2x", @"png"),
                             LOADIMAGE(@"loading5@2x", @"png"),
                             LOADIMAGE(@"loading6@2x", @"png"),
                             LOADIMAGE(@"loading7@2x", @"png"),
                             LOADIMAGE(@"loading8@2x", @"png"),
                             LOADIMAGE(@"loading9@2x", @"png"),nil];
        gifImageView.animationImages = gifArray; //动画图片数组
        gifImageView.animationDuration = 0.8; //执行一次完整动画所需的时长
        gifImageView.animationRepeatCount =0;  //动画重复次数
        [gifImageView startAnimating];
        
        UILabel *alertLable = [[UILabel alloc]initWithFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width/2+gifImageView.frame.size.width/2, gifImageView.frame.size.height-5, [UIScreen mainScreen].bounds.size.width, 30)];
        alertLable.font = [UIFont systemFontOfSize:12];
        alertLable.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
        alertLable.numberOfLines = 0;
        
        alertLable.text = string;
        alertLable.textAlignment = NSTextAlignmentCenter;
        [gifImageView addSubview:alertLable];
        
        
        return gifImageView;
    }
}


@end
