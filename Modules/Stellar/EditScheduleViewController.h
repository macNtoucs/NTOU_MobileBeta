//
//  EditScheduleViewController.h
//  MIT Mobile
//
//  Created by mac_hero on 12/10/27.
//
//

#import <UIKit/UIKit.h>
#import "SetWeekTimesViewController.h"
#import "NTOU_ClassColorViewController.h"
#import "MBProgressHUD.h"
@interface EditScheduleViewController : UITableViewController<EditDataBaseDelegate,UITextFieldDelegate,UIAlertViewDelegate,MBProgressHUDDelegate> {
    int willbeset_WeekTimes;
    int willbeset_ClassSessionTimes;
    bool willbeset_showClassTimes;
    MBProgressHUD *HUD;
}

@end
