//
//  SetTimeViewController.h
//  MIT Mobile
//
//  Created by R MAC on 12/12/17.
//
//
#import "SecondaryGroupedTableViewCell.h"
#import <UIKit/UIKit.h>

@class SetTimeViewController;
@protocol SetTimeViewControllerDelegate <NSObject>

-(void)HTTime:(SetTimeViewController *) controller nowselectedTime:(NSString *)Time;

@end


@interface SetTimeViewController : UITableViewController{
    NSArray * HT_timeArr_morning;
    NSArray * HT_timeArr_evening;
    NSArray * HT_timeArr_night;
    NSArray * HT_timeArr_noon;
    NSArray * TimeCategory;
    __unsafe_unretained id<SetTimeViewControllerDelegate> delegate;
}


@property (nonatomic,unsafe_unretained)id delegate;
@end
