//
//  BaseWebViewController.m
//  xjdoctor
//
//  Created by mySon on 16/1/13.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "BaseWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "XJJSObject.h"

@interface BaseWebViewController ()
{
    NSInteger count;
}

@property(nonatomic,strong)UIBarButtonItem *closeBtn;

@end

@implementation BaseWebViewController
//隐藏左导航按钮
- (id)initWithHiddenLeftBarButtonItem {
    self = [super init];
    if (self) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view = self.webView;
    
    //判断web页数
    int webNum=0;
    for (UIViewController *view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[BaseWebViewController class]]) {
            ++webNum;
            if (webNum>=3) {
                self.navigationItem.rightBarButtonItem=self.closeBtn;
                break;
            }
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //返回刷新
    if (count) {
         [_webView stringByEvaluatingJavaScriptFromString:@"appReload();"];
    }
    count++;
}

#pragma mark - init

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        _webView.scrollView.delegate=self;
        _webView.scalesPageToFit =YES;
        _webView.opaque=NO;
        [_webView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    }
    return _webView;
}

- (UIBarButtonItem *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(popRootView)];
    }
    return _closeBtn;
}


#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* scheme = [[request URL] scheme];
    
    if ([scheme isEqualToString:@"about"]||[scheme isEqualToString:@"objc"]){
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self initWebScriptMethod];
    [self showHudInView:self.view hint:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHud];
//    //获取标题
//    NSString *titleStr= [NSString Analysis:@"title" webaddress:self.urlStr];
//    titleStr=[titleStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if (titleStr.length>0) {
//        self.title = titleStr;
//    }else {
//        //页面默认标签
//        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    }

    //去掉web响应事件
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self showHintError:@"加载失败"];
}

//滑动监测
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_isChangeSwipe) {
        //下滑
        if (- scrollView.contentOffset.y / _webView.frame.size.height > 0.05) {
            if ([self.delegate respondsToSelector:@selector(changeSwipeDown)]) {
                [self.delegate changeSwipeDown];
            }
        }else{
            float height = scrollView.contentSize.height > _webView.frame.size.height ?_webView.frame.size.height : scrollView.contentSize.height;
            //上滑
            if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.05) {
                if ([self.delegate respondsToSelector:@selector(changeSwipeUp)]) {
                    [self.delegate changeSwipeUp];
                }
            }
        }
    }
}


#pragma mark 初始化提供js调用的方法

-(void) initWebScriptMethod{
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    XJJSObject *jsObj=[[XJJSObject alloc]initWithController:self];
    context[@"app"]=jsObj;
}

#pragma mark - Action

//根据本地html文件名加载html页面
- (void)LoadWithHtmlName:(NSString *)htmlName {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    
    NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding: NSUTF8StringEncoding error:&error];
    if (error == nil) {//数据加载没有错误情况下
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
}

//根据url地址加载html页面
- (void)LoadWithUrl:(NSString *)urlString {
    self.urlStr = urlString;
    NSString* secretAgent = [self.webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newUagent = [NSString stringWithFormat:@"%@ %@",secretAgent,@"appCode"];
    NSDictionary *dictionary = [[NSDictionary alloc]
                                initWithObjectsAndKeys:newUagent, @"UserAgent",nil,nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //创建一个 NSMutableURLRequest 添加 header
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    [mutableRequest addValue:[MainViewController sharedInstance].userModel.token forHTTPHeaderField:@"token"];
//    [mutableRequest addValue:[Config sharedInstance].appCode forHTTPHeaderField:@"appCode"];
//    request = [mutableRequest copy];
    [self.webView loadRequest:request];
}

- (void)pushNewWebView:(NSString *)urlString {
    BaseWebViewController *baseWebView = [[BaseWebViewController alloc]init];
    [baseWebView LoadWithUrl:urlString];
    [self.navigationController pushViewController:baseWebView animated:YES];
}

//返回首页
- (void)popRootView {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
