//
//  UISearchBar+SLMFramework.m
//  FICorpUMSApp
//
//  Created by flaginfo－mac4 on 14-10-28.
//  Copyright (c) 2014年 flaginfo. All rights reserved.
//

#import "UISearchBar+SLMFramework.h"
#import "SLMFunctions.h"

@implementation UISearchBar (SLMFramework)

- (void)slm_setCancelButtonTitle:(NSString *)title
{
    //修改search bar cancel button
    UIButton *cancelButton = nil;
    
    if (slm_iOS7OrLater()) {
        UIView *topView = self.subviews[0];
        for (UIView *subView in topView.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                cancelButton = (UIButton*)subView;
            }
        }
    }
    else {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                cancelButton = (UIButton*)subView;
            }
        }
    }
    if (cancelButton){
        [cancelButton.superview sendSubviewToBack:cancelButton];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    
//    if (slm_iOS8OrLater()) {
        [self insertSubview:cancelButton atIndex:1];
//    }
}

@end
