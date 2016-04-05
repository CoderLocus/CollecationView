//
//  ViewController.m
//  CollectionView
//
//  Created by 井庆林 on 16/4/5.
//  Copyright © 2016年 JingQL. All rights reserved.
//


#import "ViewController.h"
#import "ImageCell.h"
#import "GPCollectionLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)NSMutableArray * images;

@property(nonatomic, weak)UICollectionView * collectionView;

@end

@implementation ViewController

static NSString *const className = @"ImageCell";

-(NSArray *)images
{
    if (_images == nil) {
        self.images = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%.2d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //流水布局
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, 375, 200) collectionViewLayout:[[GPCollectionLayout alloc]init]];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:className];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
#pragma mark 切换布局
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[GPCollectionLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init] animated:YES];
    }else
    {
        [self.collectionView setCollectionViewLayout:[[GPCollectionLayout alloc]init] animated:YES];
    }
}

#pragma mark 点击 item 删除

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //删除模型数据
    [_images removeObjectAtIndex:indexPath.item];
    //删除并刷新
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}



#pragma mark UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
    
    cell.imageName = _images[indexPath.item];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
