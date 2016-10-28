//
//  FavoriteModel.h
//  TestWebNav
//
//  Created by kong on 16/7/25.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYWebModel.h"

@interface FavoriteModel : AYWebModel

@property (nonatomic, copy) NSString *current_price;

@property (nonatomic, copy) NSString *depart_city;

@property (nonatomic, copy) NSString *image_url;

@property (nonatomic, copy) NSString *is_abroad;

@property (nonatomic, copy) NSString *original_price;

@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, copy) NSString *product_name;

@property (nonatomic, copy) NSString *product_sub_name;

@property (nonatomic, copy) NSString *product_sub_type;

@property (nonatomic, copy) NSString *product_type;


- (id)initContentWithDic:(NSDictionary *)jsonDic;

@end
