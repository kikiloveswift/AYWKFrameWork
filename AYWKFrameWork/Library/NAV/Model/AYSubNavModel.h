//
//  AYSubNavModel.h
//  Aoyou
//
//  Created by kong on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//  导航栏数据

#import "AYWebModel.h"

@interface AYSubNavModel : AYWebModel

/**
 *  导航栏标题
 */
@property (nonatomic,copy) NSString *header_title;

/**
 *  导航栏背景色
 */
@property (nonatomic,copy) NSString *background_color;

/**
 *  功能按钮
 */
@property (nonatomic, strong) NSArray *function_button;

/**
 *  电话号码
 */
@property (nonatomic, copy)NSString *tel_num;

/**
 *  DIV翻页
 */
@property (nonatomic, copy)NSString *back_function_name;

/**
 *  是否显示
 */
@property (nonatomic, strong)NSNumber *is_visible;


- (id)initContentWithDic:(NSDictionary *)jsonDic;

@end
