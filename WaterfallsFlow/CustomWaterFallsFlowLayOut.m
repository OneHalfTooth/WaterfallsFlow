//
//  CustomWaterFallsFlowLayOut.m
//  WaterfallsFlow
//
//  Created by 马少洋 on 16/5/13.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "CustomWaterFallsFlowLayOut.h"

@interface CustomWaterFallsFlowLayOut()

/** 设置代理 */
@property (nonatomic,weak)id<CustomWaterFallsFlowLayOutDelegate> delegate;

/** 列的高度 */
@property (nonatomic,strong)NSMutableArray * heightArray;
/** item的属性 */
@property (nonatomic,strong)NSMutableArray * attributesArray;
/** 内容视图的高度 */
@property (nonatomic,assign)CGFloat contentViewHeight;




/** get获取上下左右间距 */
- (UIEdgeInsets)edgeInsets;
/** get获取列数 */
- (NSInteger)columnsByIndex:(NSInteger)index;
/** 获取行间距 */
- (CGFloat)rowMargin;
/** 获取列间距 */
- (CGFloat)columensMargin;

@end

@implementation CustomWaterFallsFlowLayOut

- (instancetype)initWithDelegate:(id<CustomWaterFallsFlowLayOutDelegate>)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return  self;
}
- (void)prepareLayout{
    [super prepareLayout];
    [self calculateData];
}

#pragma mark -- 计算item的属性
- (void)calculateData {
    /** 删除所有元素 */
    [self.attributesArray removeAllObjects];
    /** 计算内容视图的初始高度 */
    self.contentViewHeight = self.edgeInsets.top;
    /** 获取section 的个数 */
    for (NSInteger i = 0; i < [self.collectionView numberOfSections]; i ++) {
        [self.attributesArray addObject: [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]]];
        /** 初始化行高 */
        [self customRemoveAllObjectsIndex:i];
        /** 获取每个section的itme个数 */
        for (NSInteger r = 0; r < [self.collectionView numberOfItemsInSection:i]; r ++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:r inSection:i];
            NSLog(@"%ld,%ld",indexPath.section,indexPath.item);
            [self.attributesArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
        [self.attributesArray addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]] ];
    self.contentViewHeight = [self maxColumenesHeightFromIndex:i];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return  self.attributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    CGFloat viewOriY = self.contentViewHeight;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        size = [self headerSizeIndex:indexPath.section];
    }else{
        size = [self footerSizeIndex:indexPath.section];
    }
    self.contentViewHeight += size.height;
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    attributes.frame = CGRectMake(0, viewOriY, size.width, size.height);
    [self changeAllHeightArray:self.contentViewHeight];
    return attributes;
}

//返回indexPath的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    /** 获取item的高 */
    CGFloat itemHeight = [self.delegate CustomWaterFallsFlowLayOut:self heightForItemAtIndexPath:indexPath];
    /** 获取item的宽 */
    CGFloat itemWidth = (self.collectionView.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right - self.columensMargin * ([self columnsByIndex:indexPath.section] - 1)) / [self columnsByIndex:indexPath.section];

    /** 获取行高最小的一列 */
    NSInteger minColumensIndex = [self minColumnesHeightFromIndex:indexPath.section];
    CGFloat itemOriX = self.edgeInsets.left + (minColumensIndex * (self.columensMargin + itemWidth));
    CGFloat itemOriY = 0;
    if (indexPath.section == 0) {
        itemOriY = [[self.heightArray objectAtIndex:minColumensIndex] doubleValue] + self.edgeInsets.top;
    }else{
        itemOriY = [[self.heightArray objectAtIndex:minColumensIndex] doubleValue] + self.rowMargin;
    }

    UICollectionViewLayoutAttributes * layoutAttribues = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSLog(@"index = {%ld,%ld},itemHeight = %lf,itemOriY = %lf",indexPath.section,indexPath.item,itemHeight,itemOriY);
    layoutAttribues.frame = CGRectMake(itemOriX, itemOriY, itemWidth, itemHeight);
    /** 更新最大行高 */
    self.heightArray[minColumensIndex] = @(CGRectGetMaxY(layoutAttribues.frame));
    return layoutAttribues;
}

//返回collectionView的内容视图的高度
- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width, self.contentViewHeight + self.edgeInsets.bottom);
}
#pragma mark -- 变化所有的行高
/** 变化所有的行高 */
- (void)changeAllHeightArray:(CGFloat)height{
    NSInteger count = self.heightArray.count;
    [self.heightArray removeAllObjects];
    for (NSInteger i = 0; i < count; i ++) {
        [self.heightArray addObject:@(height)];
    }
}

#pragma mark -- 获取最大行高
- (CGFloat)maxColumenesHeightFromIndex:(NSInteger)index {
    CGFloat minColumensHeight = [[self.heightArray firstObject] doubleValue];
    for (NSInteger i = 1; i < [self columnsByIndex:index]; i ++) {
        if (minColumensHeight < [[self.heightArray objectAtIndex:i]doubleValue]) {
            minColumensHeight = [[self.heightArray objectAtIndex:i]doubleValue];
        }
    }
    return minColumensHeight;
}
#pragma mark -- 获取行高最小的那一行
- (NSInteger)minColumnesHeightFromIndex:(NSInteger)index {
    NSInteger minColumensIndex = 0;
    CGFloat minColumensHeight = [[self.heightArray firstObject] doubleValue];
    for (NSInteger i = 1; i < [self columnsByIndex:index]; i ++) {
        if (minColumensHeight > [[self.heightArray objectAtIndex:i]doubleValue]) {
            minColumensHeight = [[self.heightArray objectAtIndex:i]doubleValue];
            minColumensIndex = i;
        }
    }
    return minColumensIndex;
}
#pragma mark -- 改变行高
- (void)customRemoveAllObjectsIndex:(NSInteger)index{
    if (index == 0) {
        [self.heightArray removeAllObjects];
        for (NSInteger i = 0; i < [self columnsByIndex:index]; i ++) {
            [self.heightArray addObject:@(0)];
        }
    }else{
        NSNumber * number = @([self maxColumenesHeightFromIndex:index]);
        [self.heightArray removeAllObjects];
        for (NSInteger i = 0; i < [self columnsByIndex:index]; i ++) {
            [self.heightArray addObject:number];
        }
    }

}
#pragma mark -- 懒加载
- (NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [[NSMutableArray alloc]init];
    }
    return  _heightArray;
}
- (NSMutableArray *)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc]init];
    }
    return _attributesArray;
}
#pragma mark -- get获取行间距
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginFromCustomWaterFallsFlowLayOut:)]) {
        return [self.delegate rowMarginFromCustomWaterFallsFlowLayOut:self];
    }else{
        return 10;
    }
}

#pragma mark -- get获取列间距
- (CGFloat)columensMargin {
    if ([self.delegate respondsToSelector:@selector(columensMarginFromCustomWaterFallsFlowLayOut:)]) {
        return [self.delegate columensMarginFromCustomWaterFallsFlowLayOut:self];
    }else{
        return 10;
    }

}

#pragma mark -- get获取上下左右的间距
- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsFromCustomWaterFallsFlowLayOut:)]) {
        return [self.delegate edgeInsetsFromCustomWaterFallsFlowLayOut:self];
    }else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}
#pragma mark -- 获取第index区的列数
- (NSInteger)columnsByIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(numberOfColumnsInSectionCustomWaterFallsFlowLayOut:columnsForItemAtIndex:)]) {
        return [self.delegate numberOfColumnsInSectionCustomWaterFallsFlowLayOut:self columnsForItemAtIndex:index];
    }else{
        return 2;
    }
}

#pragma mark -- 获取section的头视图
/** 获取section的头视图 */
- (CGSize)headerSizeIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(collectionViewCustomWaterFallsFlowLayOut:referenceSizeForHeaderInSection:)]) {
        [self.delegate collectionViewCustomWaterFallsFlowLayOut:self referenceSizeForHeaderInSection:index];
    }
    return CGSizeMake(0, 0);
}

#pragma mark -- 获取section的尾视图
/** 获取section的尾视图 */
- (CGSize)footerSizeIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(collectionViewCustomWaterFallsFlowLayOut:referenceSizeForFooterInSection:)]) {
        return [self.delegate collectionViewCustomWaterFallsFlowLayOut:self referenceSizeForFooterInSection:index];
    }
    return CGSizeMake(0, 0);
}


@end
