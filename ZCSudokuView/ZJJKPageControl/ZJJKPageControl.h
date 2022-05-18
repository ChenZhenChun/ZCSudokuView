//
//  ZJJKPageControl.h
//  AiyoyouCocoapods
//
//  Created by zjjk on 2022/5/17.
//  Copyright © 2020 zjjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJJKPageControl : UIControl

@property (nonatomic,strong) UIImage *dotImage;
@property (nonatomic,strong) UIImage *currentDotImage;

@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;

/// Default is 4 by 4
@property (nonatomic) CGSize dotSize;
@property (nonatomic) CGSize currentDotSize;

/// Spacing between two dot views. Default is 6.
@property (nonatomic,assign) NSInteger spacingBetweenDots;

/// Number of pages for control. Default is 0.
@property (nonatomic,assign) NSInteger numberOfPages;

/// Current page on which control is active. Default is 0.
@property (nonatomic,assign) NSInteger currentPage;


@end
