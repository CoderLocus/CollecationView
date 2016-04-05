//
//  ImageCell.m
//  CollecationView
//
//  Created by JingQL on 15/9/11.
//  Copyright (c) 2015年 JingQL. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation ImageCell

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    UIImage * image = [UIImage imageNamed:imageName];
    _imageView.image = image;
}

-(void)awakeFromNib
{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 5;
}

@end
