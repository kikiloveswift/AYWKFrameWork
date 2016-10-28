//
//  AYWebSubNavView.m
//  Aoyou
//
//  Created by kong on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//


#import "AYWebSubNavView.h"
#import "AYWebNavTableViewCell.h"
#import "AYWebNavModel.h"
typedef void(^BuildBlock)(void);

@interface AYWebSubNavView()
{
    
}

/**
 *  刷新UIBlock
 */
@property (nonatomic, copy) BuildBlock thenBlcok;

@end

@implementation AYWebSubNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
    }
    return self;
}


- (void)setSubNavModel:(AYSubNavModel *)subNavModel
{
    if (_subNavModel != subNavModel) {
        _subNavModel = subNavModel;
    }
    
    [self initUIWith:subNavModel];
    
}

/**
 *  根据JS传过来的值自定义布局Nav
 *
 *  @param subNavModel
 */
- (void)initUIWith:(AYSubNavModel *)subNavModel
{
    for (id view in self.subviews)
    {
        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[AYFunctionButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    //给父类的电话号码 复制 因为tabelView在父类中写着
    super.tel_num = self.subNavModel.tel_num;
    //装入...的button
    NSArray *dataArr = nil;
    
    //...左边的button
    if (self.subNavModel.background_color) {
        unsigned long hexBackColor = strtoul([self.subNavModel.background_color UTF8String],0,16);
        self.backgroundColor = UIColorFromRGB(hexBackColor);
    }
    //FIXME: 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KWidth - 200)/2, 29, 200, 25)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.text = self.subNavModel.header_title;
    [self addSubview:titleLabel];
    
    //FIXME: 返回按钮 功能 在私有的VC中单独定制 因为有的页面是1级页面有的是二级页面
    
    for (NSInteger i = self.subNavModel.function_button.count; i > 0; i--) {
        id object = self.subNavModel.function_button[i - 1];
        if ([object isKindOfClass:[NSString class]]) {
            //左边的button
            AYFunctionButton *button = [AYFunctionButton buttonWithType:UIButtonTypeCustom];
            if ([object isEqualToString:@"share"]) {
                [button setImage:[UIImage imageNamed:@"hybrid_share"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeShare;
                
            }else if ([object isEqualToString:@"favorite"]){
                [button setImage:[UIImage imageNamed:@"hybrid_starfavor"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeFavourite;
            }else if ([object isEqualToString:@"tel"]){
                [button setImage:[UIImage imageNamed:@"hybrid_telicon"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeTel;
            }else if ([object isEqualToString:@"my_favorite"]){
                [button setImage:[UIImage imageNamed:@"hybrid_favorbag"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeMy_Favourite;
            }else if ([object isEqualToString:@"history"]){
                [button setImage:[UIImage imageNamed:@"hybrid_history"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeHistory;
            }else if ([object isEqualToString:@"home"]){
                [button setImage:[UIImage imageNamed:@"hybrid_home"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeHome;
            }else if ([object isEqualToString:@"search"]){
                [button setImage:[UIImage imageNamed:@"hybrid_search"] forState:UIControlStateNormal];
                button.actionType = ActionTableTypeSearch;
            }
            button.frame = CGRectMake(0, 29, 30, 30);
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.tag = 2000 + i;
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
        }else if ([object isKindOfClass:[NSArray class]]){
            dataArr = [NSArray arrayWithArray:object];
            AYFunctionButton *button = [AYFunctionButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"hybrid_more"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 29, 30, 30);
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1999;
            [self addSubview:button];
        }
    }
    
    if (dataArr.count ==0)
    {
        //没有...
        for (int i = 0; i < self.subNavModel.function_button.count; i ++) {
            AYFunctionButton *button = (AYFunctionButton *)[self viewWithTag:(2001 + i)];
            button.origin = CGPointMake(KWidth - (30 + 10) * (i + 1), 29);
        }
    }else{
        //有...
        AYFunctionButton *buttonPoint = (AYFunctionButton *)[self viewWithTag:1999];
        buttonPoint.origin = CGPointMake(KWidth - 40, 29);
        for (NSInteger i = self.subNavModel.function_button.count - 1; i > 0 ; i --) {
            AYFunctionButton *button = (AYFunctionButton *)[self viewWithTag:(2000 + i)];
            button.origin = CGPointMake(KWidth - (30 + 10) * (self.subNavModel.function_button.count - i + 1), 29);
        }
    }
    
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr removeAllObjects];
    for (int i = 0; i < dataArr.count; i ++) {
        AYWebNavModel *model = [[AYWebNavModel alloc] init];
        model.labelText = dataArr[i];
        model.imgName = dataArr[i];
        [mArr addObject:model];
    }
    self.dataArr = mArr;
    [self.tabView reloadData];
    
}


/**
 *  ...左边的按钮点击事件
 *
 *  @param button
 */
- (void)btnAction:(AYFunctionButton *)button
{
    [super didSelectedWith:button.actionType];
}

/**
 *  ...按钮点击事件
 *
 *  @param btn
 */
- (void)moreBtnClick:(UIButton *)btn
{
    //点击按钮的时候关闭键盘 BUG 1297
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    //防止测试人员多次点击此按钮多次调用动画方法
    if (self.alphaView.hidden == NO) {
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        [super showAnimation];
    } completion:^(BOOL finished) {
        self.alphaView.hidden = NO;
    }];
}


@end
