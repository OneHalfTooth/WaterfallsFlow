//
//  ViewController.m
//  WaterfallsFlow
//
//  Created by 马少洋 on 16/5/13.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "ViewController.h"
#import "CustomWaterFallsFlowLayOut.h"


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
//    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    YYFPSLabel * label = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:label];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

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



//itme的height
-(CGFloat)CustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f + arc4random_uniform(100);
}
- (NSInteger)numberOfColumnsInCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut{
    return 2;
}
- (CGFloat)rowMarginFromCustomWaterFallsFlowLayOut:(CustomWaterFallsFlowLayOut *)CustomWaterFallsFlowLayOut{
    return 10;
}
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
