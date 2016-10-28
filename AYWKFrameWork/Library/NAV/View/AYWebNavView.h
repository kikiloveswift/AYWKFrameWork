//
//  AYWebNavView.h
//  Aoyou
//
//  Created by kong on 16/7/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYWebSubModel.h"

@protocol CancleShareDelegate <NSObject>

//取消分享
- (void)delegatecancleShare;

//添加到收藏
- (void)addToFavorite;

@end

//@interface AYWebNavView : UIView<UITableViewDataSource, UITableViewDelegate, CancleShareDelegate, LogInViewController_iPhoneDelegate>
@interface AYWebNavView : UIView<UITableViewDataSource, UITableViewDelegate>



/**
 *  此数据源为分享页面弹出的 数据源平台类型的数据源
 */
@property (nonatomic, strong)NSArray *data;

/**
 *  遮罩视图
 */
@property (nonatomic, strong) UIView *alphaView;

/**
 *  tableView
 */
@property (nonatomic, strong) UITableView *tabView;

/**
 *  此model填充气泡tableView
 */
@property (nonatomic, strong)AYWebSubModel *model;


/**
 *  tableView数据源
 */
@property (nonatomic, strong) NSArray *dataArr;

/**
 *  装入收藏modelArr
 */
@property (nonatomic, strong)NSArray *favoriteArr;


/**
 *  里面装的是分享链接 标题等等数据
 */
@property (nonatomic, strong)NSArray *contentArr;


/**
 *  从子类里拿到tel_num
 */
@property (nonatomic, copy) NSString *tel_num;



- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  分享动作
 */
- (void)addShareView;

/**
 *  气泡弹出动画
 */
- (void)showAnimation;


- (void)didSelectedWith:(ActionTableType)type;

@end
