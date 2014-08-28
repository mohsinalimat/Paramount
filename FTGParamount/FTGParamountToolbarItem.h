//
//  FTGParamountToolbarItem.h
//  FTGParamountDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTGParamountToolbarItem : UIButton

+ (instancetype)toolbarItemWithTitle:(NSString *)title image:(UIImage *)image;

+ (UIColor *)defaultBackgroundColor;

@end