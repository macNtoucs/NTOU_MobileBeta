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

@interface RouteDetailViewController : UITableViewController<UIApplicationDelegate,EGORefreshTableHeaderDelegate>
{
         NSMutableArray *item;
         NSURL* waitTime1_103;
        NSURL* waitTime2_103;
        NSURL* waitTime1_104;
        NSURL* waitTime2_104;
    BOOL dir;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    UIBarButtonItem *anotherButton;
    NSTimer * refreshTimer;
    NSDate * lastRefresh;
    
}

- (void) getURL:(NSString* ) inputURL;
- (void) addRoutesURL: (NSString *)_103First
                 and: (NSString *)_103Second
                 and: (NSString *)_104First
                 and: (NSString *)_104Second;
-(void)goBackMode:(BOOL)go; //true 往市區
@property (nonatomic, retain) NSMutableArray* item;
@property (nonatomic , retain) NSMutableArray* waitTime;
@property (nonatomic ,retain)  NSURL* waitTime1_103;
@property (nonatomic ,retain)  NSURL* waitTime2_103;
@property (nonatomic ,retain)  NSURL* waitTime1_104;
@property (nonatomic ,retain)  NSURL* waitTime2_104;
@property (nonatomic, retain) UIBarButtonItem *anotherButton;
@property (nonatomic, retain) NSTimer *refreshTimer;
@property (nonatomic, retain) NSDate *lastRefresh;

@end
