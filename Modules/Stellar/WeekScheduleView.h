//
//  WeekScheduleView.h
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "ClassLabelBasis.h"
#import "ClassInfoViewController.h"
#import "ClassDataBase.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol WeekScheduleViewDelegate <NSObject>
@required
-(void) showClassInfo:(ClassLabelBasis *)label;
-(BOOL) NavigationBarHidden;
-(void) DisplayUITextField:(NSArray *)info;
@end

@class ScheduleViewController;
@interface WeekScheduleView : UIView <UIGestureRecognizerDelegate>{
    NSArray *color;
    ScheduleViewController *parent_ViewController;
    NSMutableArray* course;
    NSMutableArray* TapAddCourse;
}

@property bool WhetherTapped;
@property (nonatomic, retain) NSMutableArray* TapAddCourse;
@property (nonatomic, assign)ScheduleViewController *parent_ViewController;

-(void) getParent_ViewController:(ScheduleViewController *)recieve;
@end
