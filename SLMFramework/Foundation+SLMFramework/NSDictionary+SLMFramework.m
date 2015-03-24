#import "NSDictionary+SLMFramework.h"

@implementation NSDictionary (SLMFramework)

- (NSString *)slm_JSONRepresentation
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    
    
    if (!data || error) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
#if __has_feature(objc_arc)
    return string;
#else
    return [string autorelease];
#endif
}

- (NSMutableDictionary *)slm_mutableDeepCopy
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:[self count]];
    int i;
    for (i = 0; i < self.allKeys.count; i++) {
        id key = [self.allKeys objectAtIndex:i];
        id object = [self valueForKey:key];
        id copyObject = nil;
        if ([object respondsToSelector:@selector(slm_mutableDeepCopy)]) {
            copyObject = [object slm_mutableDeepCopy];
        }
        else if ([object respondsToSelector:@selector(mutableCopy)]) {
            copyObject = [object mutableCopy];
        }
        else {
            copyObject = [object copy];
        }
        [result setValue:copyObject forKey:key];
    }
    return result;
}

@end
