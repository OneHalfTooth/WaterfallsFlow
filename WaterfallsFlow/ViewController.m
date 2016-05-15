//
//  ViewController.m
//  WaterfallsFlow
//
//  Created by 马少洋 on 16/5/13.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "ViewController.h"
#import "CustomWaterFallsFlowLayOut.h"



//时候添加区头尾
#define flag



@interface ViewController ()<UICollectionViewDataSource,CustomWaterFallsFlowLayOutDelegate>

/** collection */
@property (nonatomic,strong)UICollectionView * collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomWaterFallsFlowLayOut * layout = [[CustomWaterFallsFlowLayOut alloc]initWithDelegate:self];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Identifier"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"IdenFoot"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IdenHeader"];
//    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    YYFPSLabel * label = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:label];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 8;
}
#ifdef flag
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * temp;
    UILabel * view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.tag = 1111;
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
    temp = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IdenHeader" forIndexPath:indexPath];
        view.text = @"头";
//        view.frame = CGRectMake(0, 0, 0, 0);
        temp.backgroundColor = [UIColor blueColor];

//        temp.backgroundColor = [UIColor yellowColor];
        if (![temp viewWithTag:1111]) {
            [temp addSubview:view];

        }

    }
    else{
    temp = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"IdenFoot" forIndexPath:indexPath];
        temp.backgroundColor = [UIColor blueColor];
        view.text = @"尾";
        if (![temp viewWithTag:1111]) {
            [temp addSubview:view];
        }
    }


    return temp;
}
#else
#endif

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 23;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Identifier" forIndexPath:indexPath];

    UILabel * label = (UILabel *)[cell.contentView viewWithTag:1111];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 1111;
        [cell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"%d - %d",indexPath.section,indexPath.item];


    cell.backgroundColor = [UIColor redColor];
    return  cell;
}


-(UIEdgeInsets)edgeInsetsFromCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut{
    return UIEdgeInsetsMake(64, 10, 0, 10);
}

//itme的height
-(CGFloat)CustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f + arc4random_uniform(100);
}
- (NSInteger)numberOfColumnsInCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut{
    return 2;
}
- (NSInteger)numberOfColumnsInSectionCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut columnsForItemAtIndex:(NSInteger)index{
    NSArray * array = @[@(1),@(5),@(2),@(8),@(4),@(3),@(5),@(4),@(3),@(2)];
    return [[array objectAtIndex:index]integerValue];
}
- (CGFloat)rowMarginFromCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut{
    return 10;
}
#ifdef flag
- (CGSize)collectionViewCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 30);
}
- (CGSize)collectionViewCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 30);
}
#else
#endif
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return <#expression#>
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return <#expression#>
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return <#expression#>
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return <#expression#>
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
@end
