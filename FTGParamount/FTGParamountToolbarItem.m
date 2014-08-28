//
//  FTGParamountToolbarItem.m
//  FTGParamountDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGParamountToolbarItem.h"

@interface FTGParamountToolbarItem ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

@end

@implementation FTGParamountToolbarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [[self class] titleFont];
        self.backgroundColor = [[self class] defaultBackgroundColor];
        [self setTitleColor:[[self class] defaultTitleColor] forState:UIControlStateNormal];
        [self setTitleColor:[[self class] disabledTitleColor] forState:UIControlStateDisabled];
    }
    return self;
}

+ (instancetype)toolbarItemWithTitle:(NSString *)title
{
    FTGParamountToolbarItem *toolbarItem = [self buttonWithType:UIButtonTypeCustom];
    toolbarItem.title = title;
    toolbarItem.image = [[UIImage alloc] init];

    [toolbarItem setTitle:title forState:UIControlStateNormal];
    [toolbarItem setImage:toolbarItem.image forState:UIControlStateNormal];

    return toolbarItem;
}


#pragma mark - Display Defaults

+ (UIFont *)titleFont
{
    return [UIFont systemFontOfSize:12.0];
}

+ (UIColor *)defaultTitleColor
{
    return [UIColor blackColor];
}

+ (UIColor *)disabledTitleColor
{
    return [UIColor colorWithWhite:121.0/255.0 alpha:1.0];
}

+ (UIColor *)highlightedBackgroundColor
{
    return [UIColor colorWithWhite:0.9 alpha:1.0];
}

+ (UIColor *)selectedBackgroundColor
{
    return [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+ (UIColor *)defaultBackgroundColor
{
    return [UIColor colorWithWhite:1.0 alpha:0.95];
}

+ (CGFloat)topMargin
{
    return 2.0;
}


#pragma mark - State Changes

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateBackgroundColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateBackgroundColor];
}

- (void)updateBackgroundColor
{
    if (self.highlighted) {
        self.backgroundColor = [[self class] highlightedBackgroundColor];
    } else if (self.selected) {
        self.backgroundColor = [[self class] selectedBackgroundColor];
    } else {
        self.backgroundColor = [[self class] defaultBackgroundColor];
    }
}


#pragma mark - UIButton Layout Overrides

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    // Bottom aligned and centered.
    CGRect titleRect = CGRectZero;
    CGSize titleSize = ([self.title sizeWithFont:[[self class] titleFont] constrainedToSize:contentRect.size]);
    titleSize = CGSizeMake(ceil(titleSize.width), ceil(titleSize.height));
    titleRect.size = titleSize;
    titleRect.origin.y = contentRect.origin.y + CGRectGetMaxY(contentRect) - titleSize.height;
    titleRect.origin.x = contentRect.origin.x + floor((contentRect.size.width - titleSize.width) / 2.0);
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize imageSize = self.image.size;
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    CGFloat availableHeight = contentRect.size.height - titleRect.size.height - [[self class] topMargin];
    CGFloat originY = [[self class] topMargin] + floor((availableHeight - imageSize.height) / 2.0);
    CGFloat originX = floor((contentRect.size.width - imageSize.width) / 2.0);
    CGRect imageRect = CGRectMake(originX, originY, imageSize.width, imageSize.height);
    return imageRect;
}


@end
