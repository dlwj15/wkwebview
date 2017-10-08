//
//  RootWebViewController.m
//  wkwebview
//
//  Created by 冯文杰 on 2017/7/31.
//  Copyright © 2017年 冯文杰. All rights reserved.
//

#import "RootWebViewController.h"
#import <Masonry.h>

#define kEstimatedProgress @"estimatedProgress"
#define kWebViewTitle @"title"

@interface RootWebViewController ()

@property (nonatomic, assign) BOOL startLoad;

@end

@implementation RootWebViewController

+ (instancetype)makeWebViewControllerWithUrlString:(NSString *)urlString
{
    RootWebViewController *webViewController = [[self alloc] init];
    webViewController.requestURLString = urlString;
    webViewController.startLoad = YES;
    return webViewController;
}

+ (instancetype)makeWebViewControllerWithUrlString:(NSString *)urlString startLoad:(BOOL)startLoad
{
    RootWebViewController *webViewController = [[self alloc] init];
    webViewController.requestURLString = urlString;
    webViewController.startLoad = startLoad;
    return webViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNavigationItemTitle = YES;
    [self addWebViewToView];
    [self addProgressViewToView];
    [self addObserverFormSelf];
    if (self.startLoad) {
        [self startLoadRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 添加KVO
- (void)addObserverFormSelf
{
    [self.lw_webView addObserver:self forKeyPath:kEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    [self.lw_webView addObserver:self forKeyPath:kWebViewTitle options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark 添加webView
- (void)addWebViewToView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.suppressesIncrementalRendering = YES;
    self.lw_webView = [[LWWKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.lw_webView.backgroundColor = [UIColor whiteColor];
    self.lw_webView.UIDelegate = self;
    self.lw_webView.navigationDelegate = self;
    self.lw_webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.lw_webView];
    [self.lw_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(self.marginTop);
    }];
}

#pragma mark 添加progressView
- (void)addProgressViewToView
{
    CGFloat top = 64;
    if (self.navigationController.navigationBarHidden) top = 20;
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1.5);
    }];
}

#pragma mark 开启加载数据
- (void)startLoadRequest
{
    [self.lw_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestURLString]]];
}

- (id)jsonObjectWithData:(id)data
{
    return [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:NULL];
}

#pragma mark KVO的回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kEstimatedProgress]) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:self.lw_webView.estimatedProgress animated:YES];
        if (self.progressView.progress == 1) {
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                self.progressView.hidden = YES;
                self.progressView.progress = 0.0;
            }];
        }
    }
    else if ([keyPath isEqualToString:kWebViewTitle] && self.addNavigationItemTitle) {
        if (object == self.lw_webView) {
            if(self.navigationController)
                self.navigationItem.title = self.lw_webView.title;
        }
    }
}

- (void)dealloc
{
    [self.lw_webView removeObserver:self forKeyPath:kEstimatedProgress];
    [self.lw_webView removeObserver:self forKeyPath:kWebViewTitle];
}


@end
