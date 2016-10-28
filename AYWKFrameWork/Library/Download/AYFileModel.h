//
//  AYFileModel.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//  

#import "AYWebModel.h"

@interface AYFileModel : AYWebModel

@property (nonatomic,copy)NSString *file;

@property (nonatomic,copy)NSString *ver;

- (id)initContentWithDic:(NSDictionary *)jsonDic;

@end
