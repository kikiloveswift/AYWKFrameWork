//
//  TestWebModel.h
//  TestWebNav
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYWebModel.h"

@interface TestWebModel : AYWebModel

@property (nonatomic, copy) NSString *share_image_url;

@property (nonatomic, copy) NSString *share_txt;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) NSArray *share_type;

@property (nonatomic, copy) NSString *share_title;

/**
 *  是否需要拼接图片
 */
@property (nonatomic, assign) ShareIMGType imgType;

@property (nonatomic, strong) id favorite;

- (id)initContentWithDic:(NSDictionary *)jsonDic;

@end
