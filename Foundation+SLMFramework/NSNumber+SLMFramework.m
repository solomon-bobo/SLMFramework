#import "NSNumber+SLMFramework.h"

@implementation NSNumber (SLMFramework)

- (NSUInteger)length
{
    NSString *string = [NSString stringWithFormat:@"%@", self];
    return string.length;
}

@end
