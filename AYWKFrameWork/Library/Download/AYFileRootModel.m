//
//  AYFileRootModel.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYFileRootModel.h"

@implementation AYFileRootModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super initContentWithDic:jsonDic];
    if (self)
    {
        if ([self.update isKindOfClass:[NSDictionary class]])
        {
            self.updateModel = [[AYFileUpdateModel alloc] initContentWithDic:self.update];
        }
        if ([self.replace isKindOfClass:[NSDictionary class]])
        {
            self.replaceModel = [[AYReplaceModel alloc] initContentWithDic:self.replace];
        }
    }
    return self;
}

@end
