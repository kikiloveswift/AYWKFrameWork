//
//  KLAnalysisData.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLAnalysisData : NSObject


/**
 网上URL路径转为本地资源路径并在本地创建文件夹

 @param responseURL 下载的URL

 @return 返回本地路径
 */
+ (NSString *)httpPathToLocalPath:(NSURL *)responseURL;


@end
