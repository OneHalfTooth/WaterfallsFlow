//
//  CustomWaterFallsFlowLayOut.h
//  WaterfallsFlow
//
//  Created by 马少洋 on 16/5/13.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomWaterFallsFlowLayOut;

@protocol CustomWaterFallsFlowLayOutDelegate <NSObject>

@required
/** 获取itme的高度 */
- (CGFloat)CustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut heightForItemAtIndexPath:(NSIndexPath *)indexPath;


@optional
/** 获取列数，默认为2 */
- (NSInteger)numberOfColumnsInSectionCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut columnsForItemAtIndex:(NSInteger)index;
/** 获取上下左右间距 */
- (UIEdgeInsets)edgeInsetsFromCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut;
/** 获取列间距 */
- (CGFloat)columensMarginFromCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut;
/** 获取行间距 */
- (CGFloat)rowMarginFromCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut;
/** 获取头视图大小 */
- (CGSize)collectionViewCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut*)CustomWaterFallsFlowLayOut referenceSizeForHeaderInSection:(NSInteger)section;
/** 获取尾视图大小 */
- (CGSize)collectionViewCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut*)CustomWaterFallsFlowLayOut referenceSizeForFooterInSection:(NSInteger)section;

@end



@interface CustomWaterFallsFlowLayOut : UICollectionViewLayout
//初始化方法
- (instancetype)initWithDelegate:(id<CustomWaterFallsFlowLayOutDelegate>)delegate;
@end
