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
#import "threedays_LessonTimeView.h"
#import "threedays_WeekNameView.h"
#import "threedays_WeekScheduleView.h"
#import "LessonTimeView.h"
@interface ScheduleViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>{

    WeekNameView *TopWeekcontroller;
    LessonTimeView *LeftViewController;
    WeekScheduleView *weekschedule;
    threedays_LessonTimeView *threedays_leftView;
    threedays_WeekNameView *threedays_topweekController;
    threedays_WeekScheduleView *threedays_weekschedule;
    UIView *UpperleftView;
    UIScrollView *scrollView;
    CGPoint scrollView_position;
    CGFloat lastScale;
    bool isWeekScheduleInScrowView; //if 3days then set to be false 
}
@property(nonatomic, retain) UIView *UpperleftView;
@property(nonatomic, retain)  WeekNameView *TopWeekcontroller;
@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic, retain) LessonTimeView *LeftViewController;
@property (nonatomic, retain)WeekScheduleView *weekschedule;
@property (nonatomic, retain)threedays_LessonTimeView *threedays_leftView;
@property (nonatomic, retain)threedays_WeekNameView *threedays_topweekController;
@property (nonatomic, retain)threedays_WeekScheduleView *threedays_weekschedule;
@end
