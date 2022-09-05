#import "RNWeekFoxQRScanReader.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>

@implementation RNWeekFoxQRScanReader
RCT_EXPORT_MODULE(QRScanReader);

RCT_EXPORT_METHOD(readerQR:(NSString *)fileUrl success:(RCTPromiseResolveBlock)success failure:(RCTResponseErrorBlock)failure){
  dispatch_sync(dispatch_get_main_queue(), ^{
    NSString *result = [self readerQR:fileUrl];
    if(result){
      success(result);
    }else{
      NSString *domain = @"google.com";
      NSString *desc = NSLocalizedString(@"没有相关二维码", @"");
      NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
      NSError *error = [NSError errorWithDomain:domain
                                           code:404
                                       userInfo:userInfo];
      failure(error);
    }
  });
}

-(NSString*)readerQR:(NSString*)fileUrl{
  fileUrl = [fileUrl stringByReplacingOccurrencesOfString:@"file://" withString:@""];
  CIContext *context = [CIContext contextWithOptions:nil];
  CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
  NSData *fileData = [[NSData alloc] initWithContentsOfFile:fileUrl];
  CIImage *ciImage = [CIImage imageWithData:fileData];
  NSArray *features = [detector featuresInImage:ciImage];
  if(!features || features.count==0){
    return nil;
  }
  CIQRCodeFeature *feature = [features objectAtIndex:0];
  NSString *scannedResult = feature.messageString;
  return scannedResult;
}

@end
