//
//  XJJSObject.m
//  xjdoctor
//
//  Created by mySon on 16/2/17.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "XJJSObject.h"

@interface XJJSObject ()

@property(nonatomic,strong)UIViewController *Controller;//

@end

@implementation XJJSObject


- (id)initWithController:(id)viewController {
    self = [super init];
    if (self) {
        _Controller = viewController;
    }
    return self;

}

//设置webViewController的title
-(void)setWebViewTitle:(NSString*)title {
    _Controller.title = title;
}

- (void)closeSelf {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_Controller.navigationController popViewControllerAnimated:YES];
    });
}

@end
