#import <Foundation/Foundation.h>

@interface NSDictionary (SLMFramework)

- (NSString *)slm_JSONRepresentation;

- (NSMutableDictionary *)slm_mutableDeepCopy;

- (id)slm_ObjectWithClass:(Class)cls;

@end
