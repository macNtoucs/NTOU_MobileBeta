#import <UIKit/UIKit.h>
#import "ConnectionWrapper.h"
#import "CameraViewController.h"
@protocol EmergencyViewControllerDelegate<NSObject>

@optional
- (void)didReadNewestEmergencyInfo;

@end


@interface EmergencyViewController : UITableViewController <UIWebViewDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    id<EmergencyViewControllerDelegate> delegate;
    
	BOOL refreshButtonPressed;
    NSString *htmlString;
	NSString *htmlFormatString;
    UIWebView *infoWebView;
    UIImagePickerController * imagePicker;
    MFMailComposeViewController *controller;
}

- (void)infoDidLoad:(NSNotification *)aNotification;
- (void)infoDidFailToLoad:(NSNotification *)aNotification;

- (void)refreshInfo:(id)sender; // force view controller to refresh itself

@property (nonatomic, retain) id<EmergencyViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *htmlString;
@property (nonatomic, retain) UIWebView *infoWebView;
@property (nonatomic, retain) UIImagePickerController * imagePicker;
@property (nonatomic, strong) MFMailComposeViewController *controller;
@end
