//
//  LjxUi.h
//  ljxPlayer
//
//  Created by MS on 15/11/23.
//  Copyright © 2015年 LjxProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LjxUi : NSObject




+ (UIImageView*)createImageView:(CGRect)cg andName:(NSString*)imageName;


+ (UILabel *)createLable:(CGRect)cg andFont:(CGFloat  )font andTextAlignment:(NSInteger)al text:(NSString*)text andColor:(UIColor*)color;

+ (UIButton*)createButtonWithFrame:(CGRect)cg Target:(id)target Action:(SEL)sel  ImageName:(NSString*)imageName andTitle:(NSString*)title;


@end
