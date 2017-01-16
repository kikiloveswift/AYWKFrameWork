//
//  WKViewController.m
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "WKViewController.h"
#import "AYHybridView.h"

@interface WKViewController ()
{
    AYHybridView *_hybridRootview;
}

@end

@implementation WKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = NO;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 100.f;
}

- (void)initUI
{
//    NSString *requestURL = @"http://192.168.103.79:8080/WKT/index.html";
    NSString *requestURL = @"http://m.aoyou.com";
    _hybridRootview = [[AYHybridView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) AndRequst:requestURL];
    [self.view addSubview:_hybridRootview];
}



@end
