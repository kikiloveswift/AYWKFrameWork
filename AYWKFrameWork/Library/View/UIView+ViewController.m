//
//  UIView+ViewController.m
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next);
    
    return nil;
}

@end
