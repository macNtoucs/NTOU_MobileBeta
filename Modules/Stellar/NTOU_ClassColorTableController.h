//
//  NTOU_ClassColorTableController.h
//  NTOUMobile
//
//  Created by mac_hero on 12/12/24.
//
//
@protocol NTOU_ClassColorTableControllerDelegate<NSObject>
@required
-(void)TableControllerChangeSlider:(UIColor *)color;
@end

#import <UIKit/UIKit.h>
#import "ClassDataBase.h"
#import "SecondaryGroupedTableViewCell.h"
#import "UIKit+MITAdditions.h"
@interface NTOU_ClassColorTableController : UITableViewController{
    id delegate;
    SecondaryGroupedTableViewCell* selectCell;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) SecondaryGroupedTableViewCell* selectCell;
@end
