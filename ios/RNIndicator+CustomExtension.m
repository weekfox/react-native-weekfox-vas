#import "RNIndicator+CustomExtension.h"

@implementation RNIndicator (CustomExtension)

- (HomeIndicatorView*) getHomeIndicatorView {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:UINavigationController.class]) {
      UIViewController *rootVc = rootViewController.childViewControllers.firstObject;
      
      NSAssert(
          [rootVc isKindOfClass:[HomeIndicatorView class]],
          @"rootViewController is not of type HomeIndicatorView as expected."
      );
      return (HomeIndicatorView*) rootVc;
    }
    NSAssert(
        [rootViewController isKindOfClass:[HomeIndicatorView class]],
        @"rootViewController is not of type HomeIndicatorView as expected."
    );
    return (HomeIndicatorView*) rootViewController;
}

@end
