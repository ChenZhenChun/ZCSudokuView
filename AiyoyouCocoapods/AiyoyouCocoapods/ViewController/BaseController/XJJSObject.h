//
//  XJJSObject.h
//  xjdoctor
//
//  Created by mySon on 16/2/17.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol XJJSObjectProtocol <JSExport>
//关闭当前页
- (void)closeSelf;
- (void)setWebViewTitle:(NSString*)title;
@end

@interface XJJSObject : NSObject<XJJSObjectProtocol>
-(id)initWithController:(id)viewController;
@end
