//
//  ClassInfoViewController.h
//  MIT Mobile
//
//  Created by mini server on 12/11/3.
//
//

#import <UIKit/UIKit.h>
#import "ClassLabelBasis.h"
#import "ClassInfoView.h"
@interface ClassInfoViewController : UITabBarController<UITabBarControllerDelegate>
{
    UIImageView* tabBarArrow;
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@end
