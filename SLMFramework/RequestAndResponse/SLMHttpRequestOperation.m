/*
 SLMHttpRequestOperation.h
 Created by solomon.
 */
#import "SLMHttpRequestOperation.h"

typedef NS_ENUM(NSUInteger, SLMHttpRequestOperationState) {
    SLMHttpRequestOperationStateReady,
    SLMHttpRequestOperationStateExcuting,
    SLMHttpRequestOperationStateFinished,
    SLMHttpRequestOperationStateCanceled,
    SLMHttpRequestOperationStatePaused,
};

static inline NSString * SLMKeyPathForState(SLMHttpRequestOperationState state) {
    switch (state) {
        case SLMHttpRequestOperationStateReady:
            return @"isReady";
        case SLMHttpRequestOperationStateExcuting:
            return @"isExecuting";
        case SLMHttpRequestOperationStateFinished:
            return @"isFinished";
        case SLMHttpRequestOperationStateCanceled:
            return @"isCancelled";
        case SLMHttpRequestOperationStatePaused:
            return @"isPaused";
    }
    return nil;
}

static NSThread *slm_httpRequestOperationDefaultThread = nil;

@interface SLMHttpRequestOperation () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (readwrite, nonatomic, assign) SLMHttpRequestOperationState state;
@property (readwrite, nonatomic, strong) NSURLRequest *request;
@property (readwrite, nonatomic, strong) NSURLConnection *connection;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;
@property (readwrite, nonatomic, strong) NSMutableData *responseData;
@property (readwrite, nonatomic, strong) NSError *error;

@end

@implementation SLMHttpRequestOperation

#pragma mark - default thread

+ (void)initialize
{
    slm_httpRequestOperationDefaultThread = [[NSThread alloc] initWithTarget:self
                                                                    selector:@selector(threadEntryPoint:)
                                                                      object:nil];
    [slm_httpRequestOperationDefaultThread start];
}

+ (void)threadEntryPoint:(id)sender
{
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    }
}

#pragma mark - initialize && dealloc

- (void)dealloc
{
    self.request = nil;
    self.connection = nil;
    self.responseData = nil;
    self.error = nil;
    
    self.lock = nil;

    self.successBlock = nil;
    self.failureBlock = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (id)initWithRequest:(NSURLRequest *)request
{
    self = [super init];
    if (self) {
        self.request = request;
        self.lock = [[NSRecursiveLock alloc] init];
        self.state = SLMHttpRequestOperationStateReady;
        self.successBlock = NULL;
        self.failureBlock = NULL;
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request success:(void (^)(id, NSData *))success failure:(void (^)(id, NSError *))failure
{
    self = [super init];
    if (self) {
        self.request = request;
        self.lock = [[NSRecursiveLock alloc] init];
        self.state = SLMHttpRequestOperationStateReady;
        self.successBlock = success;
        self.failureBlock = failure;
    }
    return self;
}

#pragma mark - instance methods

- (void)setState:(SLMHttpRequestOperationState)state
{
    [self.lock lock];
    
    NSString *oldKeyPath = SLMKeyPathForState(self.state);
    NSString *newKeyPath = SLMKeyPathForState(state);
    
    [self willChangeValueForKey:oldKeyPath];
    [self willChangeValueForKey:newKeyPath];
    _state = state;
    [self didChangeValueForKey:oldKeyPath];
    [self didChangeValueForKey:newKeyPath];
    
    [self.lock unlock];
}

- (void)operationDidStart
{
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request
                                                      delegate:self
                                              startImmediately:NO];
    [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSRunLoopCommonModes];
    [self.connection start];
}

#pragma mark - NSOperation required methods

- (void)start
{
    /*
     if the second parameter is main thread, it is also worked,
     but we still use a new thread to deal with http request.
     */
    [self performSelector:@selector(operationDidStart)
                 onThread:slm_httpRequestOperationDefaultThread
               withObject:nil
            waitUntilDone:NO];
    self.state = SLMHttpRequestOperationStateExcuting;
}

- (void)cancel
{
    if (self.isCancelled || self.isFinished) {
        return;
    }

    [super cancel];
    
    NSDictionary *userInfo = nil;
    if ([self.request URL]) {
        userInfo = [NSDictionary dictionaryWithObject:[self.request URL]
                                               forKey:NSURLErrorFailingURLErrorKey];
    }
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain
                                         code:NSURLErrorCancelled
                                     userInfo:userInfo];
    [self.connection cancel];
    [self performSelector:@selector(connection:didFailWithError:)
               withObject:self.connection
               withObject:error];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.state == SLMHttpRequestOperationStateExcuting;
}

- (BOOL)isFinished
{
    return self.state == SLMHttpRequestOperationStateFinished;
}

- (BOOL)isReady
{
    return self.state == SLMHttpRequestOperationStateReady;
}

- (BOOL)isPaused
{
    return self.state == SLMHttpRequestOperationStatePaused;
}

#pragma mark - callbacks

- (void)failed
{
    if (self.failureBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.failureBlock(self, self.error);
        });
    }
}

- (void)successed
{
    if (self.successBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlock(self, self.responseData);
        });
    }
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.error = error;
    [self failed];
    self.state = SLMHttpRequestOperationStateFinished;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self successed];
    self.state = SLMHttpRequestOperationStateFinished;
}

@end
