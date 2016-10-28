//
//  AYReplaceModel.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYReplaceModel.h"

@implementation AYReplaceModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super init];
    if (self)
    {
        if ([[jsonDic objectForKey:@".html"] isKindOfClass:[NSArray class]])
        {
            if ([jsonDic objectForKey:@".html"] != nil)
            {
                self.htmlRules = [jsonDic objectForKey:@".html"];
                if (self.htmlRules.count > 0)
                {
                    NSMutableArray *mArr = [NSMutableArray array];
                    for (NSDictionary *dic in self.htmlRules)
                    {
                        AYReplaceOldNewModel *oldNewModel = [[AYReplaceOldNewModel alloc] initContentWithDic:dic];
                        [mArr addObject:oldNewModel];
                    }
                    self.htmlRules = mArr;
                }
            }
        }
        if ([[jsonDic objectForKey:@".js"] isKindOfClass:[NSArray class]])
        {
            if ([jsonDic objectForKey:@".js"] != nil)
            {
                self.jsRules = [jsonDic objectForKey:@".js"];
                if (self.jsRules.count > 0)
                {
                    NSMutableArray *mArr = [NSMutableArray array];
                    for (NSDictionary *dic in self.jsRules)
                    {
                        AYReplaceOldNewModel *oldNewModel = [[AYReplaceOldNewModel alloc] initContentWithDic:dic];
                        [mArr addObject:oldNewModel];
                    }
                    self.jsRules = mArr;
                }
            }
        }
        if ([[jsonDic objectForKey:@".css"] isKindOfClass:[NSArray class]])
        {
            if ([jsonDic objectForKey:@".css"] != nil)
            {
                self.cssRules = [jsonDic objectForKey:@".css"];
                if (self.cssRules.count > 0)
                {
                    NSMutableArray *mArr = [NSMutableArray array];
                    for (NSDictionary *dic in self.cssRules)
                    {
                        AYReplaceOldNewModel *oldNewModel = [[AYReplaceOldNewModel alloc] initContentWithDic:dic];
                        [mArr addObject:oldNewModel];
                    }
                    self.cssRules = mArr;
                }
            }
        }
    }
    return self;

}

@end
