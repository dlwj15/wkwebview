//
//  LWWeakScriptMessageDelegate.h
//  LiwaiU
//
//  Created by fengwenjie on 2017/6/1.
//  Copyright © 2017年 gongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

/*************************************避免内存泄漏***************************************/

@interface LWWeakScriptMessageDelegate : NSObject <WKScriptMessageHandler>

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
