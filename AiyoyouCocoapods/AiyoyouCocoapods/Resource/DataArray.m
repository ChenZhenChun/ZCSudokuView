//
//  DataArray.m
//  iosDemo
//
//  Created by aiyoyou on 15/11/18.
//  Copyright © 2015年 zoe. All rights reserved.
//

#import "DataArray.h"

@implementation DataArray
+ (NSArray *)getDemoList {
    NSArray *array = @[
                       @{
                           @"demoName":@"1、九宫格",
                           @"controllerName":@"ZCSudokuViewController",
                           @"num":@"1"
                           }
                       ];
    return array;
}
@end
