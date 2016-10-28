//
//  AYWebNavView.m
//  Aoyou
//
//  Created by kong on 16/7/18.
//  Copyright © 2016年 test. All rights reserved.
//   64高度的导航栏

#import "AYWebNavView.h"
#import "AppDelegate.h"
#import "WebShareView.h"
#import "AYCollectionViewFlowLayout.h"
#import "AYWebNavTableViewCell.h"
#import "AYWebNavModel.h"
//#import "SearchViewController.h"
//#import "historyWebView.h"
//#import "MyFavoriteVC.h"

@interface AYWebNavView()
{
    
    
    UIView *coverView;
    
    CGPoint animationPoint;
    
}

@property (nonatomic, strong)AYCollectionViewFlowLayout *layout;

@end

@implementation AYWebNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    if (self)
    {
        [self initUI];
    }
    return self;
}

/**
 *  tableView数据源
 *
 *  @param dataArr SETMethod
 */
- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        
        _dataArr = dataArr;
    }
    if (self.dataArr.count > 0) {
        _tabView.frame = CGRectMake(KWidth - 135, 71, 125, 44 * self.dataArr.count);
    }
}

- (void)initUI
{
    self.backgroundColor = kColor(234, 71, 9, 1);
    
    //遮罩视图
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    _alphaView.backgroundColor = kColor(151, 151, 151, 0.1);
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appDelegate.window;
    _alphaView.hidden = YES;
    [window addSubview:_alphaView];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(0, 0, KWidth, KHeight);
    btnCancel.backgroundColor = [UIColor clearColor];
    [btnCancel addTarget:self action:@selector(btnCancel) forControlEvents:UIControlEventTouchUpInside];
    [_alphaView addSubview:btnCancel];
    
    //倒三角白色imgView
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth - 31, 64, 11, 7)];
    imgView.tag = 20160804;
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageNamed:@"hybrid_triangle"];
    [_alphaView addSubview:imgView];
    
    animationPoint = CGPointMake(imgView.frame.origin.x + imgView.frame.size.width / 2, 0);

    
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(KWidth - 135, 71, 125, 176) style:UITableViewStylePlain];
    _tabView.layer.cornerRadius = 5.0f;
    _tabView.showsVerticalScrollIndicator = NO;
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.userInteractionEnabled = YES;
    _tabView.backgroundColor = [UIColor whiteColor];
    _tabView.alpha = 0.0f;
    [_alphaView addSubview:_tabView];

    
}


- (void)btnCancel
{
    if (_alphaView.hidden == YES) {
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{

        [self showAnimation];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showAnimation {
    
    CGFloat offsetX = animationPoint.x - KWidth / 2 - 100 ;
    CGFloat offsetY = animationPoint.y - _tabView.frame.size.height / 2;
    
    if (_tabView.alpha == 0.0f) {
        UIImageView *imgView = (UIImageView *)[_alphaView viewWithTag:20160804];
        imgView.hidden = NO;
        
        [UIView animateWithDuration:0.3f animations:^{
            _tabView.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1f animations:^{
            } completion:^(BOOL finished) {
            }];
        }];
        
    } else {
        
        _tabView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        [UIView animateWithDuration:1.3 animations:^{
            _tabView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, offsetX, offsetY);
            UIImageView *imgView = (UIImageView *)[_alphaView viewWithTag:20160804];
            imgView.hidden = YES;
        } completion:^(BOOL finished) {
            _tabView.transform = CGAffineTransformIdentity;
            _tabView.alpha = 0.0f;
            _alphaView.hidden = YES;
        }];
    }
    
}




#pragma mark- UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AYWebNavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[AYWebNavTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AYWebNavTableViewCell"];
    }
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AYWebNavTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self didSelectedWith:cell.type];
    //FIXME: 去掉遮罩视图
    [self btnCancel];
    NSLog(@"%@, %@",self.viewController,self.viewController.navigationController);

}

- (void)didSelectedWith:(ActionTableType)type
{
    switch (type) {
        case ActionTableTypeFavourite:
        {
            //FIXME: 收藏
//            [self addToFavorite];
            
        }
            break;
        case ActionTableTypeMy_Favourite:
        {
            //FIXME: 我的收藏
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
//            MyFavoriteVC *favo = [sb instantiateViewControllerWithIdentifier:@"MyFavoriteVC"];
//            [self.viewController.navigationController pushViewController:favo animated:YES];
        
        }
            break;
        case ActionTableTypeHistory:
        {
            //FIXME: 历史 去我的历史
//            historyWebView *historyVC = [[historyWebView alloc] init];
//            [self.viewController.navigationController pushViewController:historyVC animated:YES];
            
        }
            break;
        case ActionTableTypeHome:
        {
            [self.viewController.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case ActionTableTypeSearch:
        {
            //FIXME: 到搜索界面
//            SearchViewController *searchVC = [[SearchViewController alloc] init];
//            [self.viewController.navigationController pushViewController:searchVC animated:YES];
        }
            break;
        case ActionTableTypeTel:
        {
            //电话
            if (self.tel_num.length > 0 && self.tel_num != nil)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.tel_num]]];
            }
        }
            break;
        case ActionTableTypeShare:
        {
            //分享
//            [self addShareView];
        }
            
        default:
            break;

    }
}

//- (void)addShareView{
//    if (coverView) {
//        coverView.hidden = NO;
//        return;
//    }
//    coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    coverView.backgroundColor = kColor(0, 0, 0, 0.6);
//    //    coverView.alpha = 0.2f;
//    
//    //初始化CollectionView
//    //    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, KHeight - KHeight / 1175 * 310, KWidth, KHeight / 1175 * 310)];
//    WebShareView *shareView = [[WebShareView alloc] initWithFrame:CGRectMake(0, khe - 220, KWidth, 220) collectionViewLayout:self.layout];
//    shareView.dataArr = self.data;
//    if (self.data == nil || self.data.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"融合框架提示：" message:@"请设置分享初始化数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    shareView.contentArr = self.contentArr;
//    shareView.favoriteArr = self.favoriteArr;
////    shareView.cancleSharedelegate = self;
//    if (shareView.block)
//    {
//        shareView.block();
//    }
//    
//    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnCancel.frame=CGRectMake(20 ,shareView.frame.size.height - 45, kScreenWidth - 40 ,40);
//    
//    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
//    
//    [btnCancel setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
//    
//    [btnCancel setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1]];
//    
//    btnCancel.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    
//    btnCancel.titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    [btnCancel addTarget:self action:@selector(cancelShare) forControlEvents:UIControlEventTouchUpInside];
//    
//    btnCancel.layer.cornerRadius = 5.0f;
//    
//    [shareView addSubview:btnCancel];
//    
//    
//    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelBtn.backgroundColor = [UIColor clearColor];
//    cancelBtn.frame = [UIScreen mainScreen].bounds;
//    [cancelBtn addTarget:self action:@selector(cancelShare) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    [window addSubview:coverView];
//    [coverView addSubview:cancelBtn];
//    [coverView addSubview:shareView];
//    
//}
//
//#pragma mark--CancleShareDelegate
//- (void)delegatecancleShare{
//
//    [self cancelShare];
//}
//
//- (void)cancelShare
//{
//    if (coverView)
//    {
//        coverView.hidden = YES;
//    }
//}
//
///**
// *  添加到收藏
// */
//- (void)addToFavorite
//{
//    if (self.favoriteArr == nil || self.favoriteArr.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"融合框架提示：" message:@"请设置收藏信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    if([user valueForKey:kMemberID] == nil)
//    {
//        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Mine" bundle:nil];
//        LoginMyAoyouController *loginVc =[storyboard instantiateViewControllerWithIdentifier:@"loginInputPage"];
//        loginVc.myLogInType=Login_Type_Pop;
//        loginVc.delegate = self;
//        [AppShare.navigationController pushViewController:loginVc animated:YES ];
//    }else{
//        NSString *memberID=[user valueForKey:kMemberID];
//        [self addCache:memberID];
//    }
//    
//}
//
//- (void)addFavotites
//{
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    NSString *memberID=[user valueForKey:kMemberID];
//    [self addCache:memberID];
//}
//
//-(void)addCache:(NSString *) memberID{
//    FavoriteModel *model = nil;
//    if ([[self.favoriteArr lastObject] isKindOfClass:[FavoriteModel class]])
//    {
//        model = (FavoriteModel *)[self.favoriteArr lastObject];
//    }
//    NSMutableDictionary *dic;
//    NSMutableDictionary *aDic;
//    NSMutableArray *CommonArray;
//    NSMutableArray *CouponArray;
//    //存储DepartureDataForSearch 缓存文件
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    //获取完整路径
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"MyFavotite.plist"];
//    NSLog(@"%@",plistPath);
//    if([fileManager fileExistsAtPath:plistPath])
//    {
//        dic =[[NSMutableDictionary alloc]  initWithContentsOfFile:plistPath];
//        NSLog(@"%@",dic);
//        aDic = [dic objectForKey:[NSString stringWithFormat:@"memberId:%@",memberID]];
//        CommonArray=[aDic objectForKey:@"common"];//旅游路线
//        CouponArray=[aDic objectForKey:@"coupon"];//抢优惠
//    }
//    else
//    {
//        [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
//    }
//    if(dic==nil){
//        dic=[[NSMutableDictionary alloc] init];
//    }
//    if(aDic==nil){
//        aDic=[[NSMutableDictionary alloc] init];
//    }
//    BOOL isFavotite=NO;
//    if(CouponArray==nil){
//        CouponArray=[[NSMutableArray alloc] init];
//    }else {
//        for (NSDictionary *d in CouponArray) {
//            if([[d objectForKey:@"ProductID"] description].intValue == model.product_id.intValue){
//                isFavotite=YES;
//                break;
//            }
//        }
//    }
//    if(CommonArray==nil){
//        CommonArray=[[NSMutableArray alloc] init];
//    }else{
//        for (NSDictionary *d in CommonArray) {
//            if([[d objectForKey:@"ProductID"] description].intValue == model.product_id.intValue){
//                isFavotite=YES;
//                break;
//            }
//        }
//    }
//    //已加入收藏
//    if(isFavotite){
//        [self CustomAlertViewWithMessage:@"已加入收藏"];
//        return;
//    }
//    NSMutableDictionary *couponDic = [[NSMutableDictionary alloc] init];
//    //自由行
//    if([model.product_type integerValue] == ProductType_Free)
//    {
//        
//        [couponDic setValue:[NSNumber numberWithInt:1] forKey:@"Type"];//1普通2、当地服务
//        [couponDic setValue:[NSString stringWithFormat:@"%@",@4] forKey:@"ProductType"];//产品类型
//        [couponDic setValue:model.product_id forKey:@"ProductID"];//产品ID
//        [couponDic setValue:model.product_name forKey:@"ProductName"];//产品名称
//        [couponDic setValue:model.image_url forKey:@"ImageUrl"];//产品图片
//        [couponDic setValue:model.product_sub_name forKey:@"ProductSubName"];//产品副标题
//        [couponDic setValue:model.original_price forKey:@"OriginalPrice"];//原价格
//        [couponDic setValue:model.current_price forKey:@"ShowPrice"];//优惠后价格
//        
//        [couponDic setValue:model.is_abroad forKeyPath:@"IsInner"];//国内游／出境游
//        [couponDic setValue:[NSNumber numberWithInt:0] forKeyPath:@"ActivityID"];//抢游惠ID
//        [couponDic setValue:[NSNumber numberWithInt:0] forKeyPath:@"DiscountFlag"];//是否为周四团购
//    }
//    //团队
//    else if([model.product_type integerValue] == ProductType_Group)
//    {
//        [couponDic setValue:[NSNumber numberWithInt:1] forKey:@"Type"];//1普通2、当地服务
//        [couponDic setValue:[NSString stringWithFormat:@"%@",model.product_type] forKey:@"ProductType"];//产品类型
//        [couponDic setValue:model.product_id forKey:@"ProductID"];//产品ID
//        [couponDic setValue:model.product_name forKey:@"ProductName"];//产品名称
//        [couponDic setValue:model.image_url forKey:@"ImageUrl"];//产品图片
//        [couponDic setValue:model.product_sub_name forKey:@"ProductSubName"];//产品副标题
//        [couponDic setValue:model.original_price forKey:@"OriginalPrice"];//原价格
//        [couponDic setValue:model.current_price forKey:@"ShowPrice"];//优惠后价格
//        
//        [couponDic setValue:model.is_abroad forKeyPath:@"IsInner"];//国内游／出境游
//        [couponDic setValue:[NSNumber numberWithInt:0] forKeyPath:@"ActivityID"];//抢游惠ID
//        [couponDic setValue:[NSNumber numberWithInt:0] forKeyPath:@"DiscountFlag"];//是否为周四团购
//    }
//    //当地玩乐
//    else if ([model.product_type integerValue] == 1002)
//    {
//        [couponDic setValue:[NSNumber numberWithInt:1] forKey:@"Type"];//1普通2、当地服务
//        [couponDic setValue:[NSString stringWithFormat:@"%@",model.product_type] forKey:@"ProductType"];//产品类型
//        [couponDic setValue:model.product_id forKey:@"ProductID"];//产品ID
//        [couponDic setValue:model.product_name forKey:@"ProductName"];//产品名称
//        [couponDic setValue:model.image_url forKey:@"ImageUrl"];//产品图片
//        [couponDic setValue:model.product_sub_name forKey:@"ProductSubName"];//产品副标题
//        [couponDic setValue:model.original_price forKey:@"OriginalPrice"];//原价格
//        [couponDic setValue:model.current_price forKey:@"ShowPrice"];//优惠后价格
//        
//        [couponDic setValue:model.is_abroad forKeyPath:@"IsInner"];//国内游／出境游
//        [couponDic setValue:[NSNumber numberWithInt:0] forKeyPath:@"ActivityID"];//抢游惠ID
//        [couponDic setValue:[NSNumber numberWithInt:0] forKeyPath:@"DiscountFlag"];//是否为周四团购
//        [couponDic setValue:model.product_sub_type forKey:@"ProductSubType"]; //子类型
//        
//    }
//    
//    
//    [CommonArray insertObject:couponDic atIndex:0];
//    [aDic setValue:CommonArray forKey:@"common"];
//    [aDic setValue:CouponArray forKey:@"coupon"];
//    [dic setValue:aDic forKey:[NSString stringWithFormat:@"memberId:%@",memberID]];
//    [fileManager removeItemAtPath:plistPath error:nil];
//    [dic writeToFile:plistPath atomically:YES];
//    [self CustomAlertViewWithMessage:@"收藏成功"];
//}
//
//-(void) CustomAlertViewWithMessage:(NSString *) message{
//    UIView *view =[[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-180)/2, kScreenHeight - 200, 180, 40)];
//    [view setBackgroundColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8]];
//    [view.layer setCornerRadius:5];
//    UILabel *lblMessage = [[UILabel alloc] init];
//    [lblMessage setFrame:CGRectMake(0, 5, view.frame.size.width, 30)];
//    [lblMessage setFont:[UIFont systemFontOfSize:12]];
//    [lblMessage setTextAlignment:NSTextAlignmentCenter];
//    [lblMessage setBackgroundColor:[UIColor clearColor]];
//    [lblMessage setTextColor:[UIColor whiteColor]];
//    [lblMessage setText:message];
//    [view addSubview:lblMessage];
//    UIWindow * window = [[UIApplication sharedApplication].delegate window];
//    [window addSubview:view];
//    //[self.view bringSubviewToFront:view];
//    [UIView animateWithDuration:0.3
//                          delay:1
//                        options: UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
//                     }
//                     completion:^(BOOL finished) {
//                         for (UIView *v in view.subviews) {
//                             [v removeFromSuperview];
//                         }
//                         [view removeFromSuperview];
//                     }];
//}
//
//
//- (AYCollectionViewFlowLayout *)layout
//{
//    if (_layout == nil)
//    {
//        _layout = [[AYCollectionViewFlowLayout alloc] init];
//        _layout.minimumInteritemSpacing = 10.0f;
//        _layout.minimumLineSpacing = 10.0f;
//        _layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//    }
//    return _layout;
//}
//
//
@end
