//
//  CameraViewController.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/2.
//
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize imagePicker;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//此為內建函式
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    //執行取消發送電子郵件畫面的動畫
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
 
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    
    [controller setToRecipients:[NSArray arrayWithObjects:@"mac.ntoucs@gmail.com", nil]];
    [controller setSubject:@"緊急事件"];
    
    [controller setMessageBody:@"[照片]" isHTML:NO];
   
    NSData *imageData = UIImagePNGRepresentation(image);
    [controller addAttachmentData:imageData mimeType:@"image/png" fileName:@"image"];
    
    [self presentModalViewController:controller animated:YES];
    
    [controller release];

    [picker dismissModalViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        hasCamera=YES;
    }else {
        hasCamera=NO;
    }
    imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:imagePicker animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
