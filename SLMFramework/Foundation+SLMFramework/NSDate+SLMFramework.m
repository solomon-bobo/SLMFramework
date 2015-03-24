#import "NSDate+SLMFramework.h"
#import "SLMFunctions.h"

@implementation NSDate (SLMFramework)

- (NSString *)slm_dayString
{
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
	NSDateFormatter *formatter = SLMAllocAndAutoReleaseObject(NSDateFormatter);
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *dayString = [formatter stringFromDate:self];
	return dayString;
}

- (NSString *)slm_dateString
{
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
	NSDateFormatter *formatter = SLMAllocAndAutoReleaseObject(NSDateFormatter);
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *dateString = [formatter stringFromDate:self];
	return dateString;
}


@end
