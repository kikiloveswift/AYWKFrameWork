//
//  AYCollectionViewFlowLayout.m
//  TestWebNav
//
//  Created by kong on 16/7/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYCollectionViewFlowLayout.h"

@interface AYCollectionViewFlowLayout()

@property (nonatomic, weak)id<UICollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, assign)UIEdgeInsets edgeInsets;

@property (nonatomic, strong)NSMutableDictionary *attributes;

@property (nonatomic, strong)NSMutableArray *itemHeightArr;

@end

@implementation AYCollectionViewFlowLayout


#pragma mark-准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.attributes = [[NSMutableDictionary alloc] init];
    
    //获取总的个数
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    self.itemHeightArr = [NSMutableArray arrayWithCapacity:[self.shareCount integerValue]];
    
    if (itemCount == 0)
    {
        return;
    }
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    //初始化 存放每行的高度
    CGFloat top = .0f;
    for (NSUInteger idx = 0; idx < [self.shareCount integerValue]; idx ++)
    {
        [_itemHeightArr addObject:[NSNumber numberWithFloat:top]];
    }
    
    //对每个Item重新布局
    for (NSUInteger index = 0; index < itemCount; index ++)
    {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    }
}

/**
 *  重新布局
 *
 *  @param indexPath
 */
- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edgeInsets = self.sectionInset;
    
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
    {
        edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    }
    
    self.edgeInsets = edgeInsets;
    
    CGSize itemSize = self.itemSize;
    //获取itemSize
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)])
    {
        itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    
    NSUInteger col = 0;
    CGFloat shortHeight = [[_itemHeightArr firstObject] floatValue];
    for (NSUInteger idx = 0; idx < _itemHeightArr.count; idx ++)
    {
        CGFloat height = [_itemHeightArr[idx] floatValue];
        if (height < shortHeight)
        {
            shortHeight = height;
            col = idx;
        }
    }
    
    float top = [[_itemHeightArr objectAtIndex:col] floatValue];
    
    //布局 margin为 当前item两行的时候 加的一个10个高度
    CGFloat margin = .0f;
    if (indexPath.item > 2) {
        margin = 10.0f;
        
    }else{
        margin = 0.0f;
    }
    
    //FIXME: 当元素只有两个的时候 设置第二个X
    CGFloat marginX = .0f;
    CGFloat marginY = .0f;
    if ([self.shareCount integerValue] == 2)
    {
        //FIXME: 如果产品需求说两个图标的时候 居上距离再远点 再微调
        marginY = 40.f;
        
        if (indexPath.item == 1) {
            marginX = KWidth/4 - 25;
        }
    }
    
    // 设置当前cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width) + marginX, top + edgeInsets.top + margin + marginY, itemSize.width, itemSize.height);
    
    [_attributes setObject:indexPath forKey:NSStringFromCGRect(frame)];
    
   
    [_itemHeightArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
    
    
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSString *rectStr in _attributes)
    {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(cellRect, rect))
        {
            NSIndexPath *indexPath = _attributes[rectStr];
            [indexPaths addObject:indexPath];
        }
    }
    
    //更新对应的数组
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:indexPaths.count];
    
    for (NSIndexPath *indexPath in indexPaths)
    {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
    }
    
    return attributes;
}

//更新对应的Frame
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    for (NSString *frame in _attributes)
    {
        if (_attributes[frame] == indexPath)
        {
            attributes.frame = CGRectFromString(frame);
        }
    }
    
    return attributes;
}

//返回contentSize的大小
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.frame.size;
    
    CGFloat maxHeight = [[_itemHeightArr firstObject] floatValue];
    
    //查找最高的列的高度
    for (NSUInteger idx = 0; idx < _itemHeightArr.count; idx++)
    {
        CGFloat colHeight = [_itemHeightArr[idx] floatValue];
        
        if (colHeight > maxHeight)
        {
            maxHeight = colHeight;
        }
    }
    
    size.height = maxHeight + self.edgeInsets.bottom;
    
    return size;
}

@end
