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
@interface ScheduleViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>{

    WeekNameView *TopWeekcontroller;
    LessonTimeView *LeftViewController;
    UIView *UpperleftView;
}
@property(nonatomic, retain) UIView *UpperleftView;
@end
