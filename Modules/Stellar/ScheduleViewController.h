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

@interface ScheduleViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,ClassAdddelegate>{
    EditScheduleViewController *editSchedule;
    WeekNameView *TopWeekcontroller;
    LessonTimeView *LeftViewController;
    WeekScheduleView *weekschedule;
    ClassInfoViewController *classInfo;
    UIView *UpperleftView;
    UIScrollView *scrollView;
    CGPoint scrollView_position;
    CGFloat lastScale;
    bool isWeekScheduleInScrowView; //if 3days then set to be false 
}
-(void) showClassInfo:(ClassLabelBasis *)label;

@property(nonatomic, retain) UIView *UpperleftView;
@property(nonatomic, retain)  WeekNameView *TopWeekcontroller;
@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic, retain) LessonTimeView *LeftViewController;
@property (nonatomic, retain)WeekScheduleView *weekschedule;
@property (nonatomic, retain) ClassInfoViewController *classInfo;
@end
