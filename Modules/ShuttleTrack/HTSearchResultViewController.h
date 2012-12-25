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
    NSArray * station;
    NSString * startStation;
    NSString * depatureStation;
    NSURL * dataURL;
    DownloadingView *downloadView;
    NSDate * selectedDate;
    NSString * selectedHTTime;
    NSString * queryResult;
    NSMutableArray * trainID;
    NSMutableArray * depatureTime;
    NSMutableArray * startTime;
    bool isFirstTimeLoad;
}

@property (nonatomic,unsafe_unretained)id dataSource;
@property (nonatomic,retain) NSDate * selectedDate;
@property (nonatomic,retain)NSString * selectedHTTime;
-(void) recieveData;

@end

@protocol HTStaionInfoDataSource <NSObject>
- (NSURL*)HTStationInfoURL:(HTSearchResultViewController *)stationInfoTableView;
- (NSString *)HTstartStationTitile:(HTSearchResultViewController *)stationInfoTableView;
- (NSString *)HTdepatureStationTitile:(HTSearchResultViewController *)stationInfoTableView;
@end
