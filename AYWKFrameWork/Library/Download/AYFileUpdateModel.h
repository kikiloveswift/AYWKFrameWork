//
//  AYFileUpdateModel.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//  Update层Model数据装入Model

#import "AYWebModel.h"


@interface AYFileUpdateModel : AYWebModel

@property (nonatomic, strong) NSArray *html;

@property (nonatomic, strong) NSArray *style;

@property (nonatomic, strong) NSArray *script;

@property (nonatomic, strong) NSArray *images;


- (id)initContentWithDic:(NSDictionary *)jsonDic;

@end
