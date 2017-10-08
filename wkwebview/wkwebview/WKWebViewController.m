//
//  WKWebViewController.m
//  wkwebview
//
//  Created by 冯文杰 on 2017/10/8.
//  Copyright © 2017年 冯文杰. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController ()

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.requestURLString =  @"http://union.liwai.com/zhiliaotoutiao/index";
    [self startLoadRequest];
    
    [self imgAddClickEvent];
}

- (void)imgAddClickEvent
{
    //防止频繁IO操作，造成性能影响
    static NSString *jsSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsSource = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImgAddClickEvent" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    });
    //添加自定义的脚本
    WKUserScript *js = [[WKUserScript alloc] initWithSource:jsSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [self.lw_webView.configuration.userContentController addUserScript:js];
    //注册回调, js具体写法请查看 ImgAddClickEvent.js 文件
    __weak typeof(self) weakSelf = self;
    [self.lw_webView lw_addScriptMessageWithName:@"imageDidClick" completionHandler:^(id messageBody) {
        NSDictionary *dict = [weakSelf jsonObjectWithData:messageBody];
        NSLog(@"%@", dict);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
