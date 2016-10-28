//
//  KLDataBase.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLDataBase.h"

//File Ver的Model
#import "AYFileModel.h"
#import "AYFileRootModel.h"

//逻辑处理
#import "KLAnalysisData.h"

@interface KLDataBase()
{
    //装文件的MArr
    NSMutableArray *_fileMArr;
    
    //装替换文件的MArr
    NSMutableArray *_replaceMArr;
}

@end

@implementation KLDataBase


static KLDataBase *_dataBase = nil;

BOOL requestFlag = NO;

+ (instancetype)shareInstance
{
    @synchronized (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _dataBase = [[self alloc] init];
            [self setting];
        });
    }
    return _dataBase;
}


+ (void)setting
{
    
}

- (void)requestAYString:(NSString *)string
                  Bulid:(buildThen)bulidBlock
{
    [KLAF requestDataWithUrlString:string Parameters:nil Method:@"GET" Success:^(id operation, id result) {
        if ([result isKindOfClass:[NSDictionary class]])
        {
            if (_fileMArr == nil)
            {
                _fileMArr = [NSMutableArray array];
            }
            if (_replaceMArr == nil)
            {
                _replaceMArr = [NSMutableArray array];
            }
            
            NSLog(@"result is %@",result);
            AYFileRootModel *rootModel = [[AYFileRootModel alloc] initContentWithDic:result];
            NSLog(@"rootModel.updateModel.html is %@", rootModel.updateModel.html);
            [_fileMArr addObject:rootModel];
            
//            AYReplaceModel *replaceModel = [[AYReplaceModel alloc] initContentWithDic:result];
//            [_replaceMArr addObject:replaceModel];
            
            if (requestFlag == NO)
            {
                if (bulidBlock)
                {
                    bulidBlock();
                    requestFlag = YES;
                }
            }else
            {
               //此时两组Model都装入_fileMArr
                NSLog(@"_replaceMArr is %@",_fileMArr);
                //1.执行下载 替换 删除原文件

                [self dobackGroundWork];
            }
        }
    } Progress:^(NSProgress *progress) {
        
    } Failure:^(id operation, NSError *error) {
        
    }];
}

- (void)dobackGroundWork
{
    for (int i = 0; i < 1; i ++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self performSelectorInBackground:@selector(beginToDownLoadFile:) withObject:_fileMArr[i]];
        });
    }
}


/**
 下载

 @param model 根Model
 */
- (void)beginToDownLoadFile:(AYFileRootModel *)model
{
    
    for (AYFileModel *fileModel in model.updateModel.html)
    {
        NSLog(@"file PathExtension is %@",fileModel.file);
        if ([[fileModel.file.pathExtension lowercaseString] isEqualToString:@"html"])
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:model.replaceModel.htmlRules];
        }else
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:nil];
        }
    }
    NSLog(@"当前线程是%@",[NSThread currentThread]);
    for (AYFileModel *fileModel in model.updateModel.style)
    {
        if ([[fileModel.file.pathExtension lowercaseString] isEqualToString:@"css"])
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:model.replaceModel.cssRules];
        }else
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:nil];
        }
    }
    
    for (AYFileModel *fileModel in model.updateModel.script)
    {
        if ([[fileModel.file.pathExtension lowercaseString] isEqualToString:@"js"])
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:model.replaceModel.jsRules];
        }else
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:nil];
        }
    }
    
    for (AYFileModel *fileModel in model.updateModel.images)
    {
        [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:nil];
    }

}

- (void)beginDownLoad:(AYFileRootModel *)model
{
//    NSLog(@"model.replaceModel.cssRules is %@",model.replaceModel.cssRules);
//    [KLDownLoad downLoadWithURL:@"http://webresource1.aoyou.com/css/webapp/msitewebsite/recommendv1.css" ReplaceRule:model.replaceModel.cssRules];
    
    for (AYFileModel *fileModel in model.updateModel.style)
    {
        if ([[fileModel.file.pathExtension lowercaseString] isEqualToString:@"css"])
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:model.replaceModel.cssRules];
        }else
        {
            [KLDownLoad downLoadWithURL:fileModel.file ReplaceRule:nil];
        }
    }
}


@end
