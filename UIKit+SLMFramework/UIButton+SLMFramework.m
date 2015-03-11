//
//  UIButton+SLMFramework.m
//  FICorpUMSApp
//
//  Created by flaginfo－mac4 on 14-9-25.
//  Copyright (c) 2014年 flaginfo. All rights reserved.
//

#import "UIButton+SLMFramework.h"

@implementation UIButton (SLMFramework)

+ (UIButton *)slm_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font frame:(CGRect)frame backgroundImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target sel:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title
            forState:UIControlStateNormal];
    [button setTitleColor:titleColor
                 forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setBackgroundImage:image
                      forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage
                      forState:UIControlStateHighlighted];
    [button addTarget:target
               action:sel
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)slm_buttonWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target sel:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image
            forState:UIControlStateNormal];
    [button setImage:highlightedImage
            forState:UIControlStateHighlighted];
    [button addTarget:target
               action:sel
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
