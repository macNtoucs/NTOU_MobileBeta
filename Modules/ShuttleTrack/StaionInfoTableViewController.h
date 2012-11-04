//
//  StaionInfoTableViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/5.
//
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"

@interface StaionInfoTableViewController : UITableViewController{
    NSURL * dataURL;
    NSMutableArray * StartAndTerminalstops;
    NSMutableArray * depatureTimes;
    NSMutableArray *arrivalTimes;
}
@property (nonatomic,retain) NSURL * dataURL;
@property (nonatomic ,retain )NSMutableArray * StartAndTerminalstops;
@property (nonatomic, retain) NSMutableArray * depatureTimes;
@property (nonatomic, retain)NSMutableArray *arrivalTimes;
-(void) recieveURL:(NSURL*) input_url;
@end
