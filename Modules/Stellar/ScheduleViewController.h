//
//  ScheduleViewController.h
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import <UIKit/UIKit.h>
#import "WeekScheduleView.h"
#import "WeekNameView.h"
#import "LessonTimeView.h"
#import "EditScheduleViewController.h"
#import "ClassAdd.h"
#import "MBProgressHUD.h"
@interface ScheduleViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,ClassAdddelegate,ClassDataBaseDelegate,WeekScheduleViewDelegate,MBProgressHUDDelegate>{
    EditScheduleViewController *editSchedule;
    WeekNameView *TopWeekcontroller;
    LessonTimeView *LeftViewController;
    WeekScheduleView *weekschedule;
    ClassInfoViewController *classInfo;
    ClassAdd* addView;
    UIView *UpperleftView;
    UIScrollView *scrollView;
    CGPoint scrollView_position;
    CGFloat lastScale;
    bool isWeekScheduleInScrowView; //if 3days then set to be false
    bool isScrollingUp;
    MBProgressHUD *HUD;
}
-(void) showClassInfo:(ClassLabelBasis *)label;

@property(nonatomic, retain) UIView *UpperleftView;
@property(nonatomic, retain)  WeekNameView *TopWeekcontroller;
@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic, retain) LessonTimeView *LeftViewController;
@property (nonatomic, retain)WeekScheduleView *weekschedule;
@property (nonatomic, retain) ClassInfoViewController *classInfo;
@end
