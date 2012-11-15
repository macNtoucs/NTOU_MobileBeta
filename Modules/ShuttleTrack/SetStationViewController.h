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
#import "TrainStyleViewController.h"
#import "StationInfoViewController.h"
@interface SetStationViewController : UITabBarController<UITabBarControllerDelegate,StationPickerPickerViewDataSource, StationPickerPickerViewDelegate,UIScrollViewDelegate,UITabBarControllerDelegate,StaionInfoDataSource>
{
    NSArray *viewControllers;
    NSArray * region;
    NSArray * station;
    NSArray *moth;
    NSMutableArray *day;
    NSString * nowSelectedRegion;
    StaionInfoTableViewController*   view5;
    TrainStyleViewController *view4;
    StationPickerPickerView *view1, *view2, *_view1, *_view2 ,*timeChoose_moth, *timeChoose_day;
    id delegate;
    int NowStationRow;
    UIView *whiteView;
    UIView *blueView;
    NSString *startStaion;
    NSString *DepatureStation;
    NSString *queryDate;
    
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@property (nonatomic ,retain) NSArray *viewControllers;
@property (nonatomic ,retain) NSArray * region;
@property (nonatomic, retain) NSString * nowSelectedRegion;
@property (nonatomic ,retain) NSArray * station;
@end
