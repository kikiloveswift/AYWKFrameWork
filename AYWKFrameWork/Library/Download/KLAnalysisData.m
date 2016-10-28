//
//  KLAnalysisData.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLAnalysisData.h"

@implementation KLAnalysisData

+ (NSString *)httpPathToLocalPath:(NSURL *)responseURL
{
    NSArray *arr = [[responseURL absoluteString] componentsSeparatedByString:@"http:/"];
    NSString *localPath = [NSString stringWithFormat:@"aoyou%@",[arr lastObject]];
    NSFileManager * fileManager = [NSFileManager defaultManager];
//    NSString *localDocumentPath = [localPath stringByDeletingLastPathComponent];

    NSString * string = [NSString stringWithFormat:@"%@%@",@"/Documents/",localPath];
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:string];

    //判断当前文件夹是否存在
    BOOL isExist = [fileManager fileExistsAtPath:[path stringByDeletingLastPathComponent]];
    
    if (isExist)
    {
        NSLog(@"文件已存在");
        
    }
    else
    {
        BOOL ret = [fileManager createDirectoryAtPath:[path stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        if (ret)
        {
            NSLog(@"创建成功");
        }
        else
        {
            NSLog(@"创建失败");
        }
    }
    return path;
}


@end
