//
//  WeekScheduleView.h
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//
#import "ClassLabelBasis.h"
#import "ClassInfoViewController.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef enum {Session,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday } ColumnName;
@class ScheduleViewController;
@interface WeekScheduleView : UIView <UIGestureRecognizerDelegate>{

    ScheduleViewController *parent_ViewController;
}

@property bool WhetherTapped;
@property (nonatomic, retain)ScheduleViewController *parent_ViewController;

-(void) getParent_ViewController:(ScheduleViewController *)recieve;
@end
