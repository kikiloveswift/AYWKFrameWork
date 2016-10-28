//
//  AYFileUpdateModel.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYFileUpdateModel.h"
#import "AYFileModel.h"

@implementation AYFileUpdateModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super initContentWithDic:jsonDic];
    if (self)
    {
        //把file Ver装入更小的Model中
        if ([self.html isKindOfClass:[NSArray class]])
        {
            NSMutableArray *mArr = [NSMutableArray array];
            if (self.html.count > 0)
            {
                for (NSDictionary *dic in self.html)
                {
                    AYFileModel *fileModel = [[AYFileModel alloc] initContentWithDic:dic];
                    [mArr addObject:fileModel];
                }
            }
            self.html = mArr;
        }
        //把file Ver装入更小的Model中
        if ([self.style isKindOfClass:[NSArray class]])
        {
            NSMutableArray *mArr = [NSMutableArray array];
            if (self.style.count > 0)
            {
                for (NSDictionary *dic in self.style)
                {
                    AYFileModel *fileModel = [[AYFileModel alloc] initContentWithDic:dic];
                    [mArr addObject:fileModel];
                }
            }
            self.style = mArr;
        }
        //把file Ver装入更小的Model中
        if ([self.script isKindOfClass:[NSArray class]])
        {
            NSMutableArray *mArr = [NSMutableArray array];
            if (self.script.count > 0)
            {
                for (NSDictionary *dic in self.script)
                {
                    AYFileModel *fileModel = [[AYFileModel alloc] initContentWithDic:dic];
                    [mArr addObject:fileModel];
                }
            }
            self.script = mArr;
        }
        //把file Ver装入更小的Model中
        if ([self.images isKindOfClass:[NSArray class]])
        {
            NSMutableArray *mArr = [NSMutableArray array];
            if (self.images.count > 0)
            {
                for (NSDictionary *dic in self.images)
                {
                    AYFileModel *fileModel = [[AYFileModel alloc] initContentWithDic:dic];
                    [mArr addObject:fileModel];
                }
            }
            self.images = mArr;
        }
    }
    return self;
}

@end
