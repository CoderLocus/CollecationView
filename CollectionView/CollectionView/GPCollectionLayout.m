//
//  GPCollectionLayout.m
//  CollicationView
//
//  Created by JingQL on 15/9/12.
//  Copyright (c) 2015年 JingQL. All rights reserved.
//

#import "GPCollectionLayout.h"

static CGFloat GPItemWH = 100;

@implementation GPCollectionLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.itemSize = CGSizeMake(GPItemWH, GPItemWH);
//        
//        CGFloat insert = ( self.collectionView.frame.size.width - GPItemWH) * 0.5;
//        
//        self.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);
//        
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        
//        self.minimumLineSpacing = 100;
    }
    return self;
}



//只要显示边界发生改变就会重新布局
//内部会重新调用prepareLayout 和 layoutAttributesForElementsInRect 获得所有 cell 的布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//一些初始化准备工作在prepareLayout做


-(void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(GPItemWH, GPItemWH);
    
    CGFloat insert = ( self.collectionView.frame.size.width - GPItemWH) * 0.5;
    
    self.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 100;
    
    
}



-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    //获取当前屏幕 frame
    CGRect rectFrame ;
    rectFrame.size = self.collectionView.frame.size;
    rectFrame.origin = self.collectionView.contentOffset;
    //取得默认的cell 的属性
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    //屏幕中点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.center.x;
    
   //遍历获得每一个attributes
    for (UICollectionViewLayoutAttributes * attributes in array) {
        
        if (CGRectIntersectsRect(rectFrame, attributes.frame)) {
            CGFloat attrX = attributes.center.x ;
            
            //计算缩放比例
            float scale = 2 - ABS(attrX - centerX) / self.collectionView.frame.size.width * 2;
            //进行缩放
            attributes.transform3D = CATransform3DMakeScale(scale, scale, 1);
        }
        //
        
    }
    
    return array;
//    return [super layoutAttributesForElementsInRect:rect];
}

/**
 *  用来设置 scrollview 停止滚动 ,那一刻的位置
 *
 *  @param proposedContentOffset 原本 scrollView 停止滚动的位置
 *
 *  @return 滚动速度
 */

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    //1.计算屏幕最后停留范围
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    //2.计算屏幕中点
    CGFloat middle = proposedContentOffset.x + rect.size.width * 0.5;
    
    //3.获得屏幕上的所有属性
    NSArray * array =  [self layoutAttributesForElementsInRect:rect];
    
    //4.遍历所有属性,获得离中间最近的attribute
    CGFloat minOffset = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attribute in array) {
        if (ABS(minOffset) > ABS(attribute.center.x - middle)) {
            minOffset = attribute.center.x - middle;
        }
    }
    
    //5.求得偏移量
    CGFloat pointX = proposedContentOffset.x + minOffset ;
    
//    CGPoint point = CGPointMake( pointX, 0);
    
    return CGPointMake(pointX, 0);
}
 

@end
