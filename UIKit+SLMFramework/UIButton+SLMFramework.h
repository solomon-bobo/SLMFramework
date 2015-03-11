//
//  UIButton+SLMFramework.h
//  FICorpUMSApp
//
//  Created by flaginfo－mac4 on 14-9-25.
//  Copyright (c) 2014年 flaginfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SLMFramework)

+ (UIButton *)slm_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font frame:(CGRect)frame backgroundImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target sel:(SEL)sel;
+ (UIButton *)slm_buttonWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target sel:(SEL)sel;

@end
