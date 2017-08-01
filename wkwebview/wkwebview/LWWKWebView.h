//
//  LWWKWebView.h
//  wkwebview
//
//  Created by 冯文杰 on 2017/7/31.
//  Copyright © 2017年 冯文杰. All rights reserved.
//

#import <WebKit/WebKit.h>

/******************JS************************/
// 在方法中使用
// window.webkit.messageHandlers.showMobile.postMessage(null)
// window.webkit.messageHandlers.协议好的脚本名称.postMessage(返参)

@interface LWWKWebView : WKWebView 

/**
 Adds a script message handler
 @!Configuration cannot be nil

 @param messageName message handler name
 @param completionHandler script message handler completion
 */
- (void)lw_addScriptMessageWithName:(NSString *)messageName completionHandler:(void (^) (id responseObject))completionHandler;


/**
 Evaluates given JavaScript string

 @param javaScriptString The javaScript string to evaluate
 @param completionHandler A block to invoke when script evaluation completes or fails
 */
- (void)lw_evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id response, NSError *error))completionHandler;


@end
