//
//  LjxUi.m
//  ljxPlayer
//
//  Created by MS on 15/11/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import "LjxUi.h"

@implementation LjxUi
+ (UIImageView*)createImageView:(CGRect)cg andName:(NSString*)imageName{
    
    UIImageView * imageVew = [[UIImageView alloc]initWithFrame:cg];
    imageVew.userInteractionEnabled  = YES;
    imageVew.image = [UIImage imageNamed:imageName];
    imageVew.userInteractionEnabled = YES;
    return imageVew;
}


+ (UILabel *)createLable:(CGRect)cg andFont:(CGFloat  )font andTextAlignment:(NSInteger)al text:(NSString*)text andColor:(UIColor*)color{
    UILabel * label = [[UILabel   alloc]initWithFrame:cg];
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment =  al;
    label.text =  text;
    label.textColor = color;
   // label.backgroundColor = [UIColor redColor];
    return label;
}

+ (UIButton*)createButtonWithFrame:(CGRect)cg Target:(id)target Action:(SEL)sel  ImageName:(NSString*)imageName andTitle:(NSString*)title{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg ;
    [bt addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    
    return bt;
}



@end
