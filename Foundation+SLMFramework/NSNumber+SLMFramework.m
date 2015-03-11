//
//  NSNumber+SLMFramework.m
//  FICorpUMSApp
//
//  Created by flaginfo－mac4 on 2/6/15.
//  Copyright (c) 2015 flaginfo. All rights reserved.
//

#import "NSNumber+SLMFramework.h"

@implementation NSNumber (SLMFramework)

- (NSUInteger)length
{
    NSString *string = [NSString stringWithFormat:@"%@", self];
    return string.length;
}

@end
