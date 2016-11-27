//
//  UITableViewCell+Separator.m
//  xjdoctor
//
//  Created by aiyoyou on 15/12/31.
//  Copyright © 2015年 zoenet. All rights reserved.
//

#import "UITableViewCell+Separator.h"

@implementation UITableViewCell (Separator)
- (void)configuraTableViewNormalSeparatorInset {
    //ios7分割线顶头
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    //ios8分割线顶头
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}
//间距
- (void)SeparatorLeftInset
{
    //ios7分割线顶头
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        
    }
    
    //ios8分割线顶头
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}


@end
