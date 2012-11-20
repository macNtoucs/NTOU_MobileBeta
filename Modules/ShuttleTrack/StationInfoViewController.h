//
//  StationInfoViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/3.
//
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "DownloadingView.h"
@protocol StaionInfoDataSource;
@interface StaionInfoTableViewController : UITableViewController{
    __unsafe_unretained id <StaionInfoDataSource> dataSource;
    NSURL * dataURL;
    NSMutableArray * StartAndTerminalstops;
    NSMutableArray * depatureTimes;
    NSMutableArray *arrivalTimes;
    NSMutableArray *trainStyle;
    NSString *startStation;
    NSString *depatureStation;
    DownloadingView *downloadView;
   
}
@property (nonatomic,retain) NSURL * dataURL;
@property (nonatomic ,retain )NSMutableArray * StartAndTerminalstops;
@property (nonatomic, retain) NSMutableArray * depatureTimes;
@property (nonatomic, retain)NSMutableArray *arrivalTimes;
@property (nonatomic, unsafe_unretained) id <StaionInfoDataSource> dataSource;
-(void) recieveData;

@end


@protocol StaionInfoDataSource <NSObject>
- (NSURL*)StationInfoURL:(StaionInfoTableViewController *)stationInfoTableView;
- (NSString *)startStationTitile:(StaionInfoTableViewController *)stationInfoTableView;
- (NSString *)depatureStationTitile:(StaionInfoTableViewController *)stationInfoTableView;
@end
