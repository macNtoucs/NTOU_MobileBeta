//
//  setHTOriginAndTerminalViewController.h
//  MIT Mobile
//
//  Created by R MAC on 12/11/26.
//
//
#import "SecondaryGroupedTableViewCell.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@protocol SetHTOriginAndStationViewDelegate <NSObject>

-(void)setHTOriginAndTerminalTableView:(UITableViewController*) tableView nowSelected:(NSString*) station;

@end

@interface setHTOriginAndTerminalViewController : UITableViewController{
    __unsafe_unretained id <SetHTOriginAndStationViewDelegate>delegate;
    __unsafe_unretained NSArray * region;
    __unsafe_unretained NSArray * station;
}
@property (nonatomic ,retain) NSArray * region;
@property (nonatomic ,retain) NSArray * station;
@property (nonatomic, unsafe_unretained) id <SetHTOriginAndStationViewDelegate> delegate;
@end

