/*
 SLMHttpRequestOperation.h
 Created by solomon.
 */
#import <Foundation/Foundation.h>

typedef void (^successBlock)(id request, NSData *responseData);
typedef void (^failureBlock)(id request, NSError *error);

@interface SLMHttpRequestOperation : NSOperation

@property (readonly, nonatomic, strong) NSURLRequest *request;
@property (readonly, nonatomic, strong) NSURLConnection *connection;
@property (readonly, nonatomic, strong) NSMutableData *responseData;
@property (readonly, nonatomic, strong) NSError *error;

@property (nonatomic, copy) successBlock successBlock;
@property (nonatomic, copy) failureBlock failureBlock;

- (id)initWithRequest:(NSURLRequest *)request;
- (id)initWithRequest:(NSURLRequest *)request success:(void (^)(id request, NSData *responseData))success failure:(void (^)(id request, NSError *error))failure;

@end
