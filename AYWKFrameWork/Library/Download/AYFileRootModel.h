//
//  AYFileRootModel.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYWebModel.h"
#import "AYFileUpdateModel.h"
#import "AYReplaceModel.h"

@interface AYFileRootModel : AYWebModel

@property (nonatomic, strong) NSDictionary *update;

@property (nonatomic, strong) NSDictionary *replace;

@property (nonatomic, strong) NSDictionary *hybridVersion;

@property (nonatomic, strong) AYFileUpdateModel *updateModel;

@property (nonatomic, strong) AYReplaceModel *replaceModel;



- (id)initContentWithDic:(NSDictionary *)jsonDic;



@end
