//
//  UIImage+tools.h
//  TSPizza
//
//  Created by taiyh on 14/10/21.
//  Copyright (c) 2014年 ETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tools)

+ (UIImage *)loadPngImageWithName:(NSString *)name;
+ (UIImage *)loadJpgImageWithName:(NSString *)name;

+ (UIImage *)createImageWithColor:(UIColor *) color;
@end
