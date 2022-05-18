//
//  ZJJKPageControl.m
//  AiyoyouCocoapods
//
//  Created by zjjk on 2022/5/17.
//  Copyright © 2020 zjjk. All rights reserved.
//

#import "ZJJKPageControl.h"

static NSInteger const kDefaultNumberOfPages = 0;
static NSInteger const kDefaultCurrentPage = 0;
static BOOL const kDefaultHideForSinglePage = YES;
static BOOL const kDefaultShouldResizeFromCenter = YES;
static NSInteger const kDefaultSpacingBetweenDots = 6;
static CGSize const kDefaultDotSize = {4, 4};
static CGSize const kDefaultCurrentDotSize = {4,4};

@interface ZJJKPageControl()

@property (nonatomic,strong) NSMutableArray *dots;
@property (nonatomic,assign) BOOL hidesForSinglePage;
@property (nonatomic,assign) BOOL shouldResizeFromCenter;

@end

@implementation ZJJKPageControl

- (id)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void)initialization {
    self.spacingBetweenDots     = kDefaultSpacingBetweenDots;
    self.numberOfPages          = kDefaultNumberOfPages;
    self.currentPage            = kDefaultCurrentPage;
    self.hidesForSinglePage     = kDefaultHideForSinglePage;
    self.shouldResizeFromCenter = kDefaultShouldResizeFromCenter;
}

- (void)sizeToFit {
    [self updateFrame:YES];
}


//更新圆点
- (void)updateDots {
    if (self.numberOfPages == 0) {
        return;
    }
    
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        
        UIView *dot;
        if (i < self.dots.count) {
            dot = [self.dots objectAtIndex:i];
        } else {
            dot = [self generateDotView];
        }
        
        [self updateDotFrame:dot atIndex:i];
    }
    
    [self changeActivity:YES atIndex:self.currentPage];
    [self hideForSinglePage];
}


/**
 *  Update frame control to fit current number of pages. It will apply required size if authorize and required.
 *
 *  @param overrideExistingFrame BOOL to allow frame to be overriden. Meaning the required size will be apply no mattter what.
 */
- (void)updateFrame:(BOOL)overrideExistingFrame {
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeForNumberOfPages:self.numberOfPages];
    
    if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }
    
    [self resetDotViews];
}



/// 计算各个圆点的位置
/// @param dot 圆点视图view
/// @param index 圆点的索引
- (void)updateDotFrame:(UIView *)dot atIndex:(NSInteger)index {
    CGFloat dotWidth = self.dotSize.width;
    CGFloat dotHeight = self.dotSize.height;
    
    //startX：第一课圆点的x左边起始位置
    CGFloat startX = (CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width)/2.0;
    //若计算的索引左侧含有选中圆点（选中圆点的宽度有可能不一样），要加上选中圆点与普通圆点宽度的差值（以普通远端宽度统一计算，若含有特殊选中圆点则要加会这个差值）
    CGFloat x = startX+(dotWidth + self.spacingBetweenDots)*index+((index>_currentPage)?(self.currentDotSize.width-self.dotSize.width):0);
    CGFloat y = (CGRectGetHeight(self.frame) - dotHeight)/2.0;
    dot.frame = CGRectMake(x, y, (index == self.currentPage)?self.currentDotSize.width:dotWidth, dotHeight);
}

/// 普通圆点生成
- (UIView *)generateDotView {
    UIView *dotView;
    dotView = [[UIImageView alloc] initWithImage:self.dotImage];
    dotView.clipsToBounds = YES;
    dotView.layer.cornerRadius = self.dotSize.height/2.0;
    dotView.userInteractionEnabled = YES;
    dotView.frame = CGRectMake(0, 0, self.dotSize.width, self.dotSize.height);
    
    if (dotView) {
        [self addSubview:dotView];
        [self.dots addObject:dotView];
    }
    
    dotView.userInteractionEnabled = YES;    
    return dotView;
}


/// 单页圆点样式确认
/// @param active  YES为当前页圆点样式；NO为其他页圆点样式
/// @param index 圆点索引
- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index {
    if (self.dotImage && self.currentDotImage) {
        UIImageView *dotView = (UIImageView *)[self.dots objectAtIndex:index];
        dotView.userInteractionEnabled = YES;
        dotView.clipsToBounds = YES;
        if (active) {
            dotView.image = self.currentDotImage;
            dotView.layer.cornerRadius = self.currentDotSize.height/2.0;
        }else {
            dotView.image = self.dotImage;
            dotView.layer.cornerRadius = self.dotSize.height/2.0;
        }
        [self updateDotFrame:dotView atIndex:index];
    }
}


/// 重置
- (void)resetDotViews {
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }
    
    [self.dots removeAllObjects];
    [self updateDots];
}


/// 单页是否隐藏处理
- (void)hideForSinglePage {
    if (self.dots.count == 1 && self.hidesForSinglePage) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

#pragma mark - Setters
- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self resetDotViews];
}

- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots {
    _spacingBetweenDots = spacingBetweenDots;
    
    [self resetDotViews];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (self.numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    NSInteger preCurrentPage = _currentPage;
    _currentPage = currentPage;
    [self changeActivity:NO atIndex:preCurrentPage];
    [self changeActivity:YES atIndex:_currentPage];
}


- (void)setDotImage:(UIImage *)dotImage {
    _dotImage = dotImage;
    [self resetDotViews];
}


- (void)setCurrentDotImage:(UIImage *)currentDotimage {
    _currentDotImage = currentDotimage;
    [self resetDotViews];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (_currentDotImage && _currentPageIndicatorTintColor) {
        _currentDotImage = [ZJJKPageControl imageWithColor:_currentPageIndicatorTintColor imageSize:_currentDotImage.size];
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (_dotImage && _pageIndicatorTintColor) {
        _dotImage = [ZJJKPageControl imageWithColor:_pageIndicatorTintColor imageSize:_dotImage.size];
    }
}

#pragma mark - Getters
- (NSMutableArray *)dots {
    if (!_dots) {
        _dots = [[NSMutableArray alloc] init];
    }
    return _dots;
}


- (CGSize)dotSize {
    if (self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = self.dotImage.size;
    }else if (CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
    }
    return _dotSize;
}

- (CGSize)currentDotSize {
    if (self.currentDotImage && CGSizeEqualToSize(_currentDotSize, CGSizeZero)) {
        _currentDotSize = self.currentDotImage.size;
    }else if (CGSizeEqualToSize(_currentDotSize, CGSizeZero)) {
        _currentDotSize = kDefaultCurrentDotSize;
    }
    return _currentDotSize;
}

/// 计算渲染分页圆点所需要的最小宽度（（分页控件总宽度-最小宽度）/2.0  可以算出原点渲染的起始位置（使原点处于中间位置））
/// @param pageCount 总页数
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount{
    return CGSizeMake((self.dotSize.width + self.spacingBetweenDots) * pageCount - self.spacingBetweenDots+(self.currentDotSize.width-self.dotSize.width), self.dotSize.height);
}

//制作纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize {
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

@end
