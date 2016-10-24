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
}

- (void)initUI
{
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"HyBrid融合页面";
    NSString *requestURL1 = @"http://192.168.99.61:8080/?devicetype=ios";
//    NSString *requestURL2 = @"http://192.168.103.98:8080/WK/index.html";
    _hybridRootview = [[AYHybridView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) AndRequst:requestURL1];
    [self.view addSubview:_hybridRootview];
    
}



@end
