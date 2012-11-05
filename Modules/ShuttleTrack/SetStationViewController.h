//
//  SetStationViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/6.
//
//

#import <UIKit/UIKit.h>
#import "ClassLabelBasis.h"
#import "StationView.h"

@interface SetStationViewController : UITabBarController<UITabBarControllerDelegate>
{
    NSArray *viewControllers;
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@property (nonatomic ,retain) NSArray *viewControllers;
@end
