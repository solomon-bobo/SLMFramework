//
//  UIAlertView+SLMFramework.h
//  SLMDemo
//
//  Created by flaginfo－mac4 on 14-7-21.
//  Copyright (c) 2014年 flaginfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (SLMFramework)

+ (void)slm_showMessage:(NSString *)message buttonTitles:(NSArray *)buttonTitles clickedAtIndex:(void (^)(NSInteger index))block;

@end
