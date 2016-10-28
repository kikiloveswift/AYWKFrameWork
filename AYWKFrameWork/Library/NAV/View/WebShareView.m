//
//  ShareView.m
//  TestWebNav
//
//  Created by kong on 16/7/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "WebShareView.h"
#import "AYCollectionViewFlowLayout.h"
#import "AYShareCollectionViewCell.h"
#import "AppDelegate.h"
#import "TestWebModel.h"
#import "FavoriteModel.h"

static NSString *const reuseIdentify = @"AYShareCollectionViewCell";

@interface WebShareView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)AYCollectionViewFlowLayout *layout;

@end

@implementation WebShareView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:239 / 255.0 blue:223 / 255.0 alpha:1];
        __weak typeof(self) weakself = self;
        self.block = ^{
            [weakself initUI];
        };
    }
    return self;
}

- (void)initUI
{
    self.collectionViewLayout = self.layout;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[AYShareCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentify];
    self.delegate = self;
    self.dataSource = self;
}

- (AYCollectionViewFlowLayout *)layout
{
    if (_layout == nil)
    {
        
        _layout = [[AYCollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 10.0f;
        _layout.minimumLineSpacing = 10.0f;
        _layout.sectionInset = UIEdgeInsetsMake(10, 30, 0, 0);
        _layout.shareCount = [NSString stringWithFormat:@"%ld",(unsigned long)self.dataArr.count];
        switch (self.dataArr.count) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                CGFloat leftMargin = (KWidth/2 - 50)/2;
                _layout.sectionInset = UIEdgeInsetsMake(20, leftMargin, 0, 0);
            }
                break;
            default:
            {
                _layout.shareCount = @"3";
                
                CGFloat leftMargin = (KWidth/2 - 75)/2;
                _layout.sectionInset = UIEdgeInsetsMake(20, leftMargin, 0, 0);
            }
                break;
        }
        
    }
    return _layout;
}

#pragma mark-UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AYShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentify forIndexPath:indexPath];
    
    //有数据的时候使用这个传值
    cell.model = self.dataArr[indexPath.item];
        
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AYShareCollectionViewCell *cell = (AYShareCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.cancleSharedelegate respondsToSelector:@selector(delegatecancleShare)])
    {
        [self.cancleSharedelegate delegatecancleShare];
    }
    
    
    
    //FIXME: 测试
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享点击"
                                                    message:@"message"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK",nil];
    
    switch (cell.shareType) {
        case ShareToSina:
        {
            alert.message = @"新浪";
            NSLog(@"新浪");
        }
            break;
        case ShareToWeChat:
        {
            alert.message = @"微信";
            NSLog(@"微信");
        }
            break;
        case ShareToWeChatFriends:
        {
            alert.message = @"朋友圈";
            NSLog(@"朋友圈");
        }
            break;
        case ShareToMessage:
        {
            alert.message = @"短信";
            NSLog(@"短信");
        }
            break;
        case ShareToLianjie:
        {
            alert.message = @"复制链接";
            NSLog(@"复制链接");
            [self CustomAlertViewWithMessage:@"复制成功"];
        }
            break;
        case ShareToFavourite:
        {
            if ([self.cancleSharedelegate respondsToSelector:@selector(addToFavorite)]) {
                [self.cancleSharedelegate addToFavorite];
            }
            
            return;
        }
            
        default:
            break;
    }
    
    if (self.contentArr != nil && self.contentArr.count > 0)
    {
        if ([[self.contentArr lastObject] isKindOfClass:[TestWebModel class]])
        {
            TestWebModel *model = (TestWebModel *)[self.contentArr lastObject];
            
            [ShareSet sharePlatForm:cell.shareType IMGType:model.imgType Title:model.share_title Content:model.share_txt UMType:nil URL:model.share_url ImageUrl:model.share_image_url Favorite:model.favorite];
            
        }
    }
    
//    [alert show];
    
}

#pragma mark -LogInViewController_iPhoneDelegate
//- (void)addFavotites
//{
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    NSString *memberID=[user valueForKey:kMemberID];
//    [self addCache:memberID];
//}
//
//-(void) addCache:(NSString *) memberID{
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

-(void) CustomAlertViewWithMessage:(NSString *) message{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake((KWidth-180)/2, KHeight - 200, 180, 40)];
    [view setBackgroundColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8]];
    [view.layer setCornerRadius:5];
    UILabel *lblMessage = [[UILabel alloc] init];
    [lblMessage setFrame:CGRectMake(0, 5, view.frame.size.width, 30)];
    [lblMessage setFont:[UIFont systemFontOfSize:12]];
    [lblMessage setTextAlignment:NSTextAlignmentCenter];
    [lblMessage setBackgroundColor:[UIColor clearColor]];
    [lblMessage setTextColor:[UIColor whiteColor]];
    [lblMessage setText:message];
    [view addSubview:lblMessage];
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:view];
    //[self.view bringSubviewToFront:view];
    [UIView animateWithDuration:0.3
                          delay:1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in view.subviews) {
                             [v removeFromSuperview];
                         }
                         [view removeFromSuperview];
                     }];
}


@end
