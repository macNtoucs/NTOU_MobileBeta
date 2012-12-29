//
//  RouteDetailViewController.h
//  bus
//
//  Created by mac_hero on 12/5/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libxml/HTMLparser.h>
#import "TFHpple.h"
#import "DepatureViewController.h"
#import "SecondaryGroupedTableViewCell.h"
@interface RouteDetailViewController : UITableViewController<UIApplicationDelegate,EGORefreshTableHeaderDelegate,UIAlertViewDelegate,NSURLConnectionDelegate>
{
         NSMutableArray *item;
         NSURL* waitTime1_103;
        NSURL* waitTime2_103;
        NSURL* waitTime1_104;
        NSURL* waitTime2_104;
    NSURL *station_waitTime1_103;
    NSURL *station_waitTime2_103;
    NSURL *station_waitTime1_104;
    NSURL *station_waitTime2_104;
    BOOL dir;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    UIBarButtonItem *anotherButton;
    NSTimer * refreshTimer;
    NSDate * lastRefresh;
    UIAlertView *  loadingAlertView;
    NSMutableData* receivedData;
    NSURLConnection *theConncetion;
    int theConncetionCount;
    bool updateTimeOnButton;
}

- (void) getURL:(NSString* ) inputURL;
- (void) addRoutesURL: (NSString *)_103First
                 and: (NSString *)_103Second
                 and: (NSString *)_104First
                 and: (NSString *)_104Second;
- (void) addStationURL : (NSString *)_103First
                and: (NSString *)_103Second
                and: (NSString *)_104First
                and: (NSString *)_104Second;
-(void)goBackMode:(BOOL)go; //true 往市區
@property (nonatomic, retain) NSMutableArray* item;
@property (nonatomic , retain) NSMutableArray* waitTime;
@property (nonatomic , retain) NSMutableData* receivedData;
@property (nonatomic ,retain)  NSURL* waitTime1_103;
@property (nonatomic ,retain)  NSURL* waitTime2_103;
@property (nonatomic ,retain)  NSURL* waitTime1_104;
@property (nonatomic ,retain)  NSURL* waitTime2_104;
@property (nonatomic ,retain)  NSURL *station_waitTime1_103;
@property (nonatomic ,retain)  NSURL *station_waitTime2_103;
@property (nonatomic ,retain)  NSURL *station_waitTime1_104;
@property (nonatomic ,retain)  NSURL *station_waitTime2_104;
@property (nonatomic, retain) UIBarButtonItem *anotherButton;
@property (nonatomic, retain) NSTimer *refreshTimer;
@property (nonatomic, retain) NSDate *lastRefresh;

@end
