//
//  OutCampusViewController.h
//  MIT Mobile
//
//  Created by mac_hero on 12/10/16.
//
//

#import <UIKit/UIKit.h>
#import "ConnectionWrapper.h"
#import "SecondaryGroupedTableViewCell.h"
#import "EmergencyData.h"
#import "UIKit+MITAdditions.h"
@interface OutCampusViewController : UITableViewController <UINavigationControllerDelegate>
{
    NSArray *emergencyData;

}
@property (nonatomic ,retain) NSArray *emergencyData;
@end
