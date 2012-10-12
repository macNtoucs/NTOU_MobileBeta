//
//  CameraViewController.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/2.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface CameraViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate>{
    UIImagePickerController * imagePicker;
    bool hasCamera;
}
@property (nonatomic, retain) UIImagePickerController * imagePicker;
@end
