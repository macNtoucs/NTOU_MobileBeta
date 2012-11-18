//
//  TrainStyleViewController.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/15.
//
//

#import <UIKit/UIKit.h>

@class TrainStyleViewController;
@protocol TrainStyleViewControllerDelegate <NSObject>
-(void)TrainStyle:(TrainStyleViewController*) tableView nowSelectedRow:(NSInteger) indexPath;
@end
@interface TrainStyleViewController : UITableViewController{
    int currentSelectRow;
    NSArray * styleName;
     __unsafe_unretained id <TrainStyleViewControllerDelegate> delegate;
}
@property (nonatomic,unsafe_unretained)id delegate;

@end
