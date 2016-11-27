//
//  BaseWebViewController.h
//  xjdoctor
//
//  Created by mySon on 16/1/13.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseWebViewControllerDelegate <NSObject>

@optional

- (void)changeSwipeUp;//上滑

- (void)changeSwipeDown;//下滑

@end



@interface BaseWebViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>

/**
 *  BaseWebViewController代理
 */
@property (nonatomic,weak)id<BaseWebViewControllerDelegate>delegate;

/**
 *  UIWebView
 */
@property(nonatomic,strong)UIWebView *webView;

/**
 *  是否是模态页面
 */
@property (nonatomic) BOOL isModalView;
/**
 *  是否是读卡
 */
@property (nonatomic,assign)BOOL isReadCard;
/**
 *  身份证信息
 */
@property (nonatomic,strong)NSData *cardData;
/**
 *  身份证头像
 */
@property (nonatomic,strong)NSData *cardImageData;
/**
 *  是否开启滑动监测，默认为NO
 */
@property (nonatomic,assign)BOOL isChangeSwipe;
/**
 *  加载的路径
 */
@property(nonatomic,copy) NSString *urlStr;

/**
 *  根据本地html文件名加载html页面
 *
 *  @param htmlName html文件名
 */
- (void)LoadWithHtmlName:(NSString*) htmlName;

/**
 *  根据url地址加载html页面
 *
 *  @param urlString Url地址
 */
- (void)LoadWithUrl:(NSString*)urlString;

/**
 *  隐藏左导航按钮
 */
- (id)initWithHiddenLeftBarButtonItem;

@end
