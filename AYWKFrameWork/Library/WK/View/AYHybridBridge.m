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
    _webView.UIDelegate = self;
    WKWebViewConfiguration *config = _webView.configuration;
    WKUserContentController *uController = config.userContentController;
    ;
    //注入多少脚本 Delloc的时候 都要全部清除掉
    [uController addScriptMessageHandler:[[AYWeakScriptMessageHandler alloc] initWithDelegate:self] name:HybridInvoke];
    
    [uController addScriptMessageHandler:[[AYWeakScriptMessageHandler alloc] initWithDelegate:self] name:HybridinitHeader];
    [uController addScriptMessageHandler:[[AYWeakScriptMessageHandler alloc] initWithDelegate:self] name:HybridDevicetype];
}




#pragma Mark--WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"message.name is %@",message.name);
    //JS内部交互可以完成的 就在内部完成
    if ([message.name isEqualToString:HybridDevicetype])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *str = [NSString stringWithFormat:@"%@"];
            [_webView evaluateJavaScript:@"" completionHandler:nil];
        });
    }
    else if ([message.name isEqualToString:HybridInvoke])
    {
        NSLog(@"body is %@", message.body);
        
        if ([message.body isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"message.body.param is %@",message.body[@"param"]);
            NSLog(@"message.body.url is %@",message.body[@"url"]);
            [self requestAPIWith:message.body];
        }
    }
    else if ([message.name isEqualToString:@"iosgetmemberid"])
    {
        
    }
    else //若需要跳出控制器 就在外部实现
    {
        if ([self.delegate respondsToSelector:@selector(jsActionToOC:)])
        {
            [self.delegate jsActionToOC:message];
        }
    }
}


#pragma Mark--
/**
 ActionInvoke

 @param params 请求API接口
 */
- (void)requestAPIWith:(NSDictionary *)params
{
    if (params == nil)
    {
        return;
    }
    
    NSString *requestStr = params[@"url"];
    NSString *index = params[@"index"];
    NSDictionary *paramsDic = [KLData dicWithCFString:params[@"param"]];
    
    [KLAF requestDataWithUrlString:[NSString stringWithFormat:@"%@%@",KNURL,requestStr] Parameters:paramsDic Method:@"POST" Success:^(id operation, id result) {
        if ([[result objectForKey:@"ReturnCode"] isEqualToNumber:@0])
        {
            
            if ([[NSThread currentThread] isMainThread])
            {
                NSString *messageJSON = [KLData _serializeMessage:result pretty:NO];
                
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
                messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];

                NSString *str = @"api.appcallback";
                NSString *jsString = [NSString stringWithFormat:@"%@('%@','%@')",str,index,messageJSON];
                [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable script, NSError * _Nullable error) {
                    NSLog(@"script is %@",script);
                }];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *jsString = [NSString stringWithFormat:@"api.appcallback(%@,%@)",index,result];
                    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable script, NSError * _Nullable error) {
                    }];
                });
            }
        }
        
        
    } Progress:^(NSProgress *progress) {
        
    } Failure:^(id operation, NSError *error) {
        
    }];
}



- (void)dealloc
{
   
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:HybridInvoke];
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:HybridinitHeader];
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:HybridDevicetype];
}

@end
