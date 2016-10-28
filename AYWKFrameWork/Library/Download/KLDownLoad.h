//
//  KLDownLoad.h
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KLDownLoad : NSObject<NSURLSessionDelegate>
/**
 下载替换并存储文件

 @param urlString url
 @param rules     替换规则字典
 */
+ (void)downLoadWithURL:(NSString *)urlString
            ReplaceRule:(NSArray*)rules;

@end
