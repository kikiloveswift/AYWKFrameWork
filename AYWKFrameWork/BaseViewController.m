//
//  BaseViewController.m
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addGesture];
    
}

- (void)addGesture
{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.navigationController.navigationBar.alpha = 0.9;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.navigationController.navigationBar.alpha = 0.5;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.navigationController.navigationBar.alpha = 0;
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            self.navigationController.navigationBar.alpha = 1;
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            self.navigationController.navigationBar.alpha = 1;
        }
            break;
            
        default:
            break;
    }
    return self.navigationController.interactivePopGestureRecognizer.enabled;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
