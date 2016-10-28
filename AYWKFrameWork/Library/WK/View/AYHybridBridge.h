//
//  AYHybridBridge.h
//  WKVSUIWebView
//
//  Created by kong on 16/9/20.
//  Copyright © 2016年 konglee. All rights reserved.
//
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1)

#define WKWebKitAvailable
#endif
#if defined(WKWebKitAvailable)

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "AYWeakScriptMessageHandler.h"

#endif

@protocol JSToOCDelegate <NSObject>

@required

- (void)jsActionToOC:(WKScriptMessage *)message;

@end


@interface AYHybridBridge : NSObject<WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

@property(nonatomic, weak) id<JSToOCDelegate> delegate;



/**
 初始化Bridge

 @param webView 传入的WebView

 @return 实例
 */
+ (instancetype)shareInstanceWith:(WKWebView *)webView;




@end
