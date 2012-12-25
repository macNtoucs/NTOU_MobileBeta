//
//  NTOU_ClassColorViewController.h
//  NTOUMobile
//
//  Created by mac_hero on 12/12/24.
//
//

#import <UIKit/UIKit.h>
#import "NTOU_ClassColorTableController.h"
@interface NTOU_ClassColorViewController : UIViewController<NTOU_ClassColorTableControllerDelegate>
@property (retain, nonatomic) IBOutlet UISlider *RedSlider;
@property (retain, nonatomic) IBOutlet UISlider *GreenSlider;
@property (retain, nonatomic) IBOutlet UISlider *BlueSlider;
@property (retain, nonatomic) IBOutlet UILabel *RedSlider_label;
@property (retain, nonatomic) IBOutlet UILabel *GreenSlider_label;
@property (retain, nonatomic) IBOutlet UILabel *BlueSlider_label;
- (IBAction)sliderValueChange:(id)sender;
- (IBAction)touchUpForSliderValue:(id)sender;
@end
