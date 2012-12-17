#import <UIKit/UIKit.h>
#import "CKViewDelegate.h"


@interface CKViewController : UIViewController <CKViewDelegate>
{
    NSDate * selectedDate;
    
}
@property (strong,nonatomic) NSDate* selectedDate;
@end