//
//  WeekScheduleView.h
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef enum {threedays_Session,threedays_Monday,threedays_Tuesday,threedays_Wednesday,threedays_Thursday,threedays_Friday,threedays_Saturday,threedays_Sunday } threedays_ColumnName;
@interface threedays_WeekScheduleView : UIView <UIGestureRecognizerDelegate>

@end
