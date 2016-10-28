//
//  AYReplaceOldNewModel.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYReplaceOldNewModel.h"

@implementation AYReplaceOldNewModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super initContentWithDic: jsonDic];
    if (self)
    {
        if ([jsonDic objectForKey:@"new"] != nil)
        {
            self.newone = [jsonDic objectForKey:@"new"];
        }
    }
    return self;
}

@end
