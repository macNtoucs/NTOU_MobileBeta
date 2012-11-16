//
//  SetOriginAndStationViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/16.
//
//

#import <UIKit/UIKit.h>
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@protocol SetOriginAndStationViewDelegate <NSObject>

-(void)SetOriginAndStationViewTableView:(UITableViewController*) tableView nowSelected:(NSString*) station;

@end

@interface SetOriginAndStationViewController : UITableViewController{
   __unsafe_unretained id <SetOriginAndStationViewDelegate>delegate;
    NSArray * region;
    NSArray * station;
}
@property (nonatomic ,retain) NSArray * region;
@property (nonatomic ,retain) NSArray * station;
@property (nonatomic, unsafe_unretained) id <SetOriginAndStationViewDelegate> delegate;
@end
