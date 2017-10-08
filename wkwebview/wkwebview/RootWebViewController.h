//
//  RootWebViewController.h
//  wkwebview
//
//  Created by 冯文杰 on 2017/7/31.
//  Copyright © 2017年 冯文杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWWKWebView.h"

@interface RootWebViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

+ (instancetype)makeWebViewControllerWithUrlString:(NSString *)urlString;

+ (instancetype)makeWebViewControllerWithUrlString:(NSString *)urlString startLoad:(BOOL)startLoad;

- (void)startLoadRequest;

- (id)jsonObjectWithData:(id)data;

@property (nonatomic, strong) LWWKWebView *lw_webView;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, copy) NSString *requestURLString;

/** default YES */
@property (nonatomic, assign) BOOL addNavigationItemTitle;

/** webView.top -> supview.top */
@property (nonatomic, assign) CGFloat marginTop;

@end
