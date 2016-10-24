//
//  AYHybridBridge.m
//  WKVSUIWebView
//
//  Created by kong on 16/9/20.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYHybridBridge.h"

@implementation AYHybridBridge
{
    WKWebView *_webView;
    __weak id<WKNavigationDelegate> navigationDelegate;
    
}

+ (instancetype)shareInstanceWith:(WKWebView *)webView
{
    AYHybridBridge *bridge = [[self alloc] init];
    [bridge setupHybridData:webView];
    return bridge;
}


/**
 初始化Data

 @param webView 当前webView
 */
- (void)setupHybridData:(WKWebView *)webView
{
    _webView = webView;
    _webView.navigationDelegate = self;
    WKWebViewConfiguration *config = _webView.configuration;
    WKUserContentController *uController = config.userContentController;
    ;
    //注入多少脚本 Delloc的时候 都要全部清除掉
    [uController addScriptMessageHandler:[[AYWeakScriptMessageHandler alloc] initWithDelegate:self] name:@"btnClick"];
    [uController addScriptMessageHandler:[[AYWeakScriptMessageHandler alloc] initWithDelegate:self] name:@"iosinvoke"];
    
    
    [uController addScriptMessageHandler:[[AYWeakScriptMessageHandler alloc] initWithDelegate:self] name:@"popAction"];
}




#pragma Mark--WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //JS内部交互可以完成的 就在内部完成
    if ([message.name isEqualToString:@"btnClick"])
    {
        NSLog(@"body is %@", message.body);
    }
    else if ([message.name isEqualToString:@"iosinvoke"])
    {
        NSLog(@"body is %@", message.body);
        
        if ([message.body isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"message.body.param is %@",message.body[@"param"]);
            NSLog(@"message.body.url is %@",message.body[@"url"]);
        }
    }
    else //控制器跳转的 就在外部实现
    {
        if ([self.delegate respondsToSelector:@selector(jsActionToOC:)])
        {
            [self.delegate jsActionToOC:message];
        }
    }
}



- (void)dealloc
{
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"btnClick"];
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"popAction"];
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"iosinvoke"];
    
}

@end
