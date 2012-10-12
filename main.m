#import <UIKit/UIKit.h>
#import "MIT_MobileAppDelegate.h"
#import "MITSpringboard.h"
int main(int argc, char *argv[]) {
    
    int retVal = 0;
    @autoreleasepool {
        NSString *classString = NSStringFromClass([MIT_MobileAppDelegate class]);
        @try {
            retVal = UIApplicationMain(argc, argv, nil, classString);
        }
        @catch (NSException *exception) {
            NSLog(@"Exception - %@",[exception description]);
            exit(EXIT_FAILURE);
        }
    }
    return retVal;
    
}
