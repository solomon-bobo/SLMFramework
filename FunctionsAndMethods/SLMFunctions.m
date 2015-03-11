#import "SLMFunctions.h"
#import <CoreGraphics/CoreGraphics.h>

NSString *slm_fileNameWithNoExtension(char *filePath)
{
    if (!filePath) {
        return nil;
    }
    
    char *lastSlash = NULL;
    char *lastDot = NULL;
    
    char *p = (char *)filePath;
    while (*p) {
        if (*p == '/') {
            lastSlash = p;
        }
        else if (*p == '.') {
            lastDot = p;
        }
        p++;
    }
    
    char *subStr = lastSlash ? lastSlash + 1 : (char *)filePath;
    NSUInteger subLength = (lastDot ? : p) - subStr;
    
#if __has_feature(objc_arc)
    return [[NSString alloc] initWithBytesNoCopy:subStr
                                          length:subLength
                                        encoding:NSUTF8StringEncoding
                                    freeWhenDone:NO];
#else
    return [[[NSString alloc] initWithBytesNoCopy:subStr
                                           length:subLength
                                         encoding:NSUTF8StringEncoding
                                     freeWhenDone:NO] autorelease];
#endif
}


UIImage *slm_image(NSString *imageName)
{
    return [UIImage imageNamed:imageName];
}

UIImage *slm_large_image(NSString *imageName)
{
    NSString *suffix = @"png";
    if ([imageName hasSuffix:@"png"]) {
        imageName = [imageName substringToIndex:imageName.length - 4];
    }
    else if ([imageName hasSuffix:@"jpg"]) {
        imageName = [imageName substringToIndex:imageName.length - 4];
        suffix = @"jpg";
    }
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:imageName ofType:suffix];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    return SLMAutoRelease(image);
}

/*
 如果在iPhone4上，icon.png为40*40像素，那么imageSize为40*40，imageScale为1.0，screenScale为2.0
 如果在iPhone4上，icon@2x.png为40*40像素，那么imageSize为20*20，imageScale为2.0，screenScale为2.0
 如果在iPhone6+上，icon.png为60*60像素，那么imageSize为60*60，imageScale为1.0，screenScale为3.0
 如果在iPhone6+上，icon@3x.png为60*60像素，那么imageSize为20*20，imageScale为3.0，screenScale为3.0
 以image的高度宽度中间的1*1进行resize。
 */
UIImage *slm_resizeImage(NSString *imageName)
{
    UIImage *image = slm_image(imageName);
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width - 1;
    CGFloat height = imageSize.height - 1;
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(height / 2, width / 2, height / 2, width / 2)];
    return newImage;
}

void slm_alert(NSString *message)
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示", @"温馨提示")
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", @"确定")
                                              otherButtonTitles:nil];
    [alertView show];
    SLMReleaseSafely(alertView);
}

NSString *slm_UUIDString()
{
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
#if __has_feature(objc_arc)
        uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
#else
        uuidString = (NSString *)CFUUIDCreateString(NULL, uuid);
#endif
        CFRelease(uuid);
    }
    return uuidString;
}

NSString *slm_GUIDString()
{
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
#if __has_feature(objc_arc)
        uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
#else
        uuidString = (NSString *)CFUUIDCreateString(NULL, uuid);
#endif
        CFRelease(uuid);
    }
    return [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}