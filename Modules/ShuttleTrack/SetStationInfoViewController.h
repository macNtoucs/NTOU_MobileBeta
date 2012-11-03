//
//  SetStationInfoViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/4.
//
//

#import <UIKit/UIKit.h>
#import "UIKit+MITAdditions.h"

@interface SetStationInfoViewController : UITableViewController{
    bool dir; //dir true 南下
}
@property (nonatomic,retain) NSMutableArray* stationName;
@end
