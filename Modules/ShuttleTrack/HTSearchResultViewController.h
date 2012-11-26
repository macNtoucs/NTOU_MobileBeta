//
//  HTSearchResultViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/26.
//
//

#import <UIKit/UIKit.h>
#import "DownloadingView.h"
#import "TFHpple.h"
#import "SecondaryGroupedTableViewCell.h"
@protocol HTStaionInfoDataSource;
@interface HTSearchResultViewController : UITableViewController{
    __unsafe_unretained id <HTStaionInfoDataSource> dataSource;
    NSURL * dataURL;
    NSMutableArray * StartAndTerminalstops;
    NSMutableArray * depatureTimes;
    NSMutableArray *arrivalTimes;
    NSString *startStation;
    NSString *depatureStation;
    DownloadingView *downloadView;
    NSMutableURLRequest *request;
    NSMutableDictionary *north;
    NSMutableDictionary *south;
    NSMutableDictionary *direction;
    NSMutableArray *north_id;
    NSMutableArray *north_taipeiStation;
    NSMutableArray *north_benchiouStation;
    NSMutableArray *north_touyounStation;
    NSMutableArray *north_shinchewStation;
    NSMutableArray *north_taichungStation;
    NSMutableArray *north_chiaiStation;
    NSMutableArray *north_tainanStation;
    NSMutableArray *north_zhouyingStation;
    NSMutableArray *south_id;
    NSMutableArray *south_taipeiStation;
    NSMutableArray *south_benchiouStation;
    NSMutableArray *south_touyounStation;
    NSMutableArray *south_shinchewStation;
    NSMutableArray *south_taichungStation;
    NSMutableArray *south_chiaiStation;
    NSMutableArray *south_tainanStation;
    NSMutableArray *south_zhouyingStation;
    NSArray * station;
    NSMutableArray * shouldDisplay_to;
    NSMutableArray * shouldDisplay_from;
    NSMutableArray * shouldDisplay_ID;
    
}

@property (nonatomic,retain) NSURL * dataURL;
@property (nonatomic ,retain )NSMutableArray * StartAndTerminalstops;
@property (nonatomic, retain) NSMutableArray * depatureTimes;
@property (nonatomic, retain)NSMutableArray *arrivalTimes;
@property (nonatomic, retain)NSString *startStation;
@property (nonatomic, retain)NSString *depatureStation;
@property (nonatomic, unsafe_unretained) id <HTStaionInfoDataSource> dataSource;
-(void) recieveData;
@end

@protocol HTStaionInfoDataSource <NSObject>
- (NSURL*)HTStationInfoURL:(HTSearchResultViewController *)stationInfoTableView;
- (NSString *)HTstartStationTitile:(HTSearchResultViewController *)stationInfoTableView;
- (NSString *)HTdepatureStationTitile:(HTSearchResultViewController *)stationInfoTableView;
@end
