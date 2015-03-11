//
//  UIView+SLMFramework.h
//  FICorpUMSApp
//
//  Created by flaginfo－mac4 on 14-9-25.
//  Copyright (c) 2014年 flaginfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SLMFramework)

- (void)slm_shake;

@property (nonatomic, assign) CGFloat slm_left;
@property (nonatomic, assign,readonly) CGFloat slm_right;
@property (nonatomic, assign) CGFloat slm_top;
@property (nonatomic, assign,readonly)CGFloat slm_bottom;
@property (nonatomic, assign) CGFloat slm_width;
@property (nonatomic, assign) CGFloat slm_height;
@property (nonatomic, assign) CGPoint slm_origin;
@property (nonatomic, assign) CGSize slm_size;
@property (nonatomic, assign) CGFloat slm_centerX;
@property (nonatomic, assign) CGFloat slm_centerY;

- (UITableViewCell *)slm_superTableViewCell;

@end
