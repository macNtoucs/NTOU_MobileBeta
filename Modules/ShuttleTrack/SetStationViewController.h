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
#import "ThroughTap.h"
#import "TrainStyleViewController.h"
#import "StationInfoViewController.h"
#import "SetOriginAndStationViewController.h"
#import "DownloadingView.h"
#import "SecondaryGroupedTableViewCell.h"
#import "setHTOriginAndTerminalViewController.h"
#import "HTSearchResultViewController.h"
#import "CKCalendarView.h"
#import "CKViewController.h"
#import "SetTimeViewController.h"
@interface SetStationViewController : UITabBarController<UITabBarControllerDelegate,UIScrollViewDelegate,UITabBarControllerDelegate,StaionInfoDataSource,SetOriginAndStationViewDelegate,TrainStyleViewControllerDelegate,SetHTOriginAndStationViewDelegate,HTStaionInfoDataSource,SetTimeViewControllerDelegate>
{
    NSArray *viewControllers;
    NSArray * region;
    NSArray * station;
    NSArray *moth;
    NSMutableArray *day;
    NSString * nowSelectedRegion;
    StaionInfoTableViewController*   view5;
    TrainStyleViewController *view4;
    SetOriginAndStationViewController *view1, *view2 ;
    setHTOriginAndTerminalViewController *HTView_origin, *HTView_terminal;
    HTSearchResultViewController *ht_searchResult;
    UIViewController *setStartStationController,
    *setdepatureStationviewController,
    *setTimeviewController,
    *setTrainTypeviewController,
    *resultViewController,
    *setHTTimeviewController;
    id delegate;
    id stationInfoTableView_delegate;
    int startStaion_origin;
    int depatureStation_origin;
    int dateSelected;
    NSString *startStaion;
    NSString *DepatureStation;
    NSString *queryDate;
    int currentMonth;
    int currentDay;
    NSMutableDictionary * stationNum;
    NSString* trainStyle;
    bool isinitData;
    DownloadingView * downloadView;
    bool _isHightSpeedTrain;
    CKViewController * calendar;
    SetTimeViewController * HTTime;
    NSString * selectedHTTime;
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@property (nonatomic ,retain) NSArray *viewControllers;
@property (nonatomic ,retain) NSArray * region;
@property (nonatomic, retain) NSString * nowSelectedRegion;
@property (nonatomic ,retain) NSArray * station;


-(id)initIsHighSpeedTrain:(bool)isHighSpeedTrain;
@end
