//
//  AYReplaceModel.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AYReplaceOldNewModel.h"

@interface AYReplaceModel : NSObject

@property (nonatomic, strong) NSArray *htmlRules;

@property (nonatomic, strong) NSArray *jsRules;

@property (nonatomic, strong) NSArray *cssRules;

//@property (nonatomic, strong) AYReplaceOldNewModel *oldNewModel;

- (id)initContentWithDic:(NSDictionary *)jsonDic;

@end
