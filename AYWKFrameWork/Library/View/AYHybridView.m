//
//  AYHybridView.m
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYHybridView.h"


@interface AYHybridView()

@property (nonatomic, copy) NSString *requestURL;


@property AYHybridBridge *bridge;

@end


@implementation AYHybridView

@synthesize useWebView = _useWebView;

- (instancetype)initWithFrame:(CGRect)frame AndRequst:(NSString *)requestURL
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _requestURL = requestURL;
        [self setUpWKConfigs];
        [self setupBridge];
    }
    return self;
}

- (void)setUpWKConfigs
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [WKPreferences new];
    configuration.userContentController = [WKUserContentController new];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_requestURL]]];
    _useWebView = webView;
    
    [self.useWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.useWebView];
    
}

- (void)setupBridge
{
    self.bridge = [AYHybridBridge shareInstanceWith:_useWebView];
    self.bridge.delegate = self;
}

#pragma Mark-JSToOCDelegate
- (void)jsActionToOC:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"popAction"])
    {
        [[self viewController].navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc
{
    self.bridge.delegate = nil;
    self.requestURL = nil;
    self.bridge = nil;
}

@end
