//
//  SLMAlertView.h
//  SLMDemo
//
//  Created by flaginfo－mac4 on 14-7-21.
//  Copyright (c) 2014年 flaginfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLMAlertView : UIAlertView

+ (void)showMessage:(NSString *)message buttonTitles:(NSArray *)buttonTitles clickedAtIndex:(void (^)(NSInteger index))block;
+ (void)showMessage:(NSString *)message title:(NSString *)title buttonTitles:(NSArray *)buttonTitles clickedAtIndex:(void (^)(NSInteger index))block;

@end
