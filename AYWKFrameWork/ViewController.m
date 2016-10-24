//
//  ViewController.m
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"
#import "WKViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushWKAction:(id)sender
{
    WKViewController *wkVC = [[WKViewController alloc] init];
    [self.navigationController pushViewController:wkVC animated:YES];
    
}

@end
