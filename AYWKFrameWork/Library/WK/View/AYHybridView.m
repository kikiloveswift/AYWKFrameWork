//
//  AYHybridView.m
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYHybridView.h"
//融合分享导入此4个文件
#import "AYWebSubNavView.h"
#import "TestWebModel.h"
#import "FavoriteModel.h"
#import "AYSubNavModel.h"
#define KUseHybrid @"isHead=1"


@interface AYHybridView()
{
    WKWebView *_webView;
    AYWebSubNavView *nav;
    UIView *redView;
}

@property (nonatomic, copy) NSString *requestURL;


@property AYHybridBridge *bridge;

@property (nonatomic, weak) CALayer *progresslayer;



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
    configuration.preferences.minimumFontSize = 10;
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    configuration.userContentController = [WKUserContentController new];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, KWidth, self.frame.size.height - 64) configuration:configuration];
    _webView.allowsBackForwardNavigationGestures = YES;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_requestURL]]];
    _useWebView = _webView;

    [self initProgressView];
    [self addKVOOserver];
    [self initNav];
    [self.useWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.useWebView];
    
//    //Test刷新
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(KWidth - 100, 84, 80, 50);
//    btn.backgroundColor = [UIColor lightGrayColor];
//    [btn setTitle:@"刷新" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
}


- (void)initNav
{
    //FIXME: 融合分享测试
    nav = [[AYWebSubNavView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 64)];
    nav.hidden = NO;
    redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 20)];
    redView.backgroundColor = kColor(233, 71, 9, 1);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(4, 29, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"title_back_11"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(navbackAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:backButton];
    
    [self addSubview:nav];
}

/**
 *  新导航栏返回  返回逻辑和安卓的一致。处理各种复杂的返回 包括Div隐藏与显示 POP等
 *
 *
 */
- (void)navbackAction:(UIButton *)button
{
    if (nav.subNavModel.back_function_name != nil && nav.subNavModel.back_function_name.length > 0)
    {
        [_webView evaluateJavaScript:nav.subNavModel.back_function_name completionHandler:nil];
    }else{
        if ([_webView canGoBack]) {
            [_webView goBack];
        }else{
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
    }
}

//初始化进度条
- (void)initProgressView
{
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_webView.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [_webView addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}



- (void)btnAction:(UIButton *)btn{
    
    [(WKWebView *)_useWebView reload];
}

- (void)setupBridge
{
    self.bridge = [AYHybridBridge shareInstanceWith:_useWebView];
    self.bridge.delegate = self;
}


#pragma Mark-JSToOCDelegate
- (void)jsActionToOC:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:HybridinitHeader])
    {
        NSDictionary *dic = [KLData dicWithJsonString:message.body];
        if ([dic isKindOfClass:[NSDictionary class]])
        {
            [self setHybridHeader:dic];
        }
    }
}

- (void)jsActionToOCAboutCurHeader:(NSString *)message Body:(id)body
{
    if ([message isEqualToString:HybridinitHeader])
    {
        NSDictionary *dic = [KLData dicWithJsonString:body];
        if ([dic isKindOfClass:[NSDictionary class]])
        {
            [self setHybridHeader:dic];
        }
    }
}

- (void)setHybridHeader:(NSDictionary *)dic
{
    AYSubNavModel *subNavModel = [[AYSubNavModel alloc] initContentWithDic:dic];
    nav.subNavModel = subNavModel;
    if ([subNavModel.is_visible  isEqual: @1]) {
        //显示
        nav.hidden = NO;
        _webView.frame = CGRectMake(0, 64, KWidth, KHeight - 64);
    }else if ([subNavModel.is_visible isEqual: @0]){
        //隐藏
        nav.hidden = YES;
        _webView.frame = CGRectMake(0, 20, KWidth, KHeight - 20);
    }
    
    NSLog(@"subModel is %@",subNavModel);
}

//添加KVO监听
- (void)addKVOOserver
{
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];

}

#pragma mark--KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, _webView.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }
    else if ([keyPath isEqualToString:@"canGoBack"])
    {
        if ([change[@"new"] boolValue])
        {
            self.viewController.fd_interactivePopDisabled = YES;
        }
        else
        {
            self.viewController.fd_interactivePopDisabled = NO;
        }
    }else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    self.bridge.delegate = nil;
    self.requestURL = nil;
    self.bridge = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    _webView = nil;
    _useWebView = nil;
}

@end
