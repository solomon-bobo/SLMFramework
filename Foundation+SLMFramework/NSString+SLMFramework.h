#import <Foundation/Foundation.h>

@interface NSString (SLMFramework)

//predicate
- (BOOL)slm_isMobilePhoneNumber;

//date
- (NSDate *)slm_date;

//json value
- (id)slm_JSONValue;

//MD5
- (id)slm_md5;

- (int)slm_chineseLength;

@end
