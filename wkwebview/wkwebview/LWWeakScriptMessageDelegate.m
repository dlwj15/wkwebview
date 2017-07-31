//
//  LWWeakScriptMessageDelegate.m
//  LiwaiU
//
//  Created by fengwenjie on 2017/6/1.
//  Copyright © 2017年 gongsheng. All rights reserved.
//

#import "LWWeakScriptMessageDelegate.h"

@interface LWWeakScriptMessageDelegate ()

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

@end

@implementation LWWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    if (self = [super init]) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}



@end
