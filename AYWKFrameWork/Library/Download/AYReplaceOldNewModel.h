//
//  AYReplaceOldNewModel.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYWebModel.h"

@interface AYReplaceOldNewModel : AYWebModel

@property (nonatomic, copy) NSString *old;

@property (nonatomic, copy) NSString *newone;

- (id)initContentWithDic:(NSDictionary *)jsonDic;



@end
