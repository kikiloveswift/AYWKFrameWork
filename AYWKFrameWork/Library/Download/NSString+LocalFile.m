//
//  NSString+LocalFile.m
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "NSString+LocalFile.h"

@implementation NSString (LocalFile)

// 传入字符串,直接在沙盒Cache中生成路径
- (instancetype)cacheDir
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [cache stringByAppendingPathComponent:[self lastPathComponent]];
}
// 传入字符串,直接在沙盒Document中生成路径
- (instancetype)docDir
{
    NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).firstObject;
    return [doc stringByAppendingPathComponent:[self lastPathComponent]];
    
}
// 传入字符串,直接在沙盒Temp中生成路径
- (instancetype)temDir
{
    
    NSString *tem = NSTemporaryDirectory();
    return [tem stringByAppendingPathComponent:[self lastPathComponent]];
    
}

@end
