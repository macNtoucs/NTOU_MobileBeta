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
#import "StationPickerPickerView.h"
#import "ThroughTap.h"
@interface SetStationViewController : UITabBarController<UITabBarControllerDelegate,StationPickerPickerViewDataSource, StationPickerPickerViewDelegate,UIScrollViewDelegate>
{
    NSArray *viewControllers;
    NSArray * region;
    NSString * nowSelectedRegion;
    StationView  *view3, *view4, *view5;
    StationPickerPickerView *view1, *view2, *_view1, *_view2;
    id delegate;
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@property (nonatomic ,retain) NSArray *viewControllers;
@property (nonatomic ,retain) NSArray * region;
@property (nonatomic, retain) NSString * nowSelectedRegion;

@end
