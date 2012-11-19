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
#import "SetOriginAndStationViewController.h"
@interface SetStationViewController : UITabBarController<UITabBarControllerDelegate,StationPickerPickerViewDataSource, StationPickerPickerViewDelegate,UIScrollViewDelegate,UITabBarControllerDelegate,StaionInfoDataSource,SetOriginAndStationViewDelegate,TrainStyleViewControllerDelegate>
{
    NSArray *viewControllers;
    NSArray * region;
    NSArray * station;
    NSArray *moth;
    NSMutableArray *day;
    NSString * nowSelectedRegion;
    StaionInfoTableViewController*   view5;
    TrainStyleViewController *view4;
    StationPickerPickerView *timeChoose_moth, *timeChoose_day;
    SetOriginAndStationViewController *view1, *view2, *_view1, *_view2 ;
    id delegate;
    id stationInfoTableView_delegate;
    int startStaion_origin;
    int depatureStation_origin;
    int dateSelected;
    UIView *whiteView;
    UIView *blueView;
    NSString *startStaion;
    NSString *DepatureStation;
    NSString *queryDate;
    int currentMonth;
    int currentDay;
    NSMutableDictionary * stationNum;
    NSString* trainStyle;
    bool isinitData;
    
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@property (nonatomic ,retain) NSArray *viewControllers;
@property (nonatomic ,retain) NSArray * region;
@property (nonatomic, retain) NSString * nowSelectedRegion;
@property (nonatomic ,retain) NSArray * station;
@end
