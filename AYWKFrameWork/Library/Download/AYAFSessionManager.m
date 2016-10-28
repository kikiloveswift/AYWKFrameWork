//
//  AYAFSessionManager.m
//  DownLoadDocument
//
//  Created by kong on 16/10/17.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYAFSessionManager.h"

static AFURLSessionManager *manager = nil;

@implementation AYAFSessionManager

+ (AFURLSessionManager *)shareSessionManager
{
    static dispatch_once_t onceTokenSessionManager;
    dispatch_once(&onceTokenSessionManager, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    return manager;
}

@end
