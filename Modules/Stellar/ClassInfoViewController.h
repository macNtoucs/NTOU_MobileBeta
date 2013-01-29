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
@interface ClassInfoViewController : UITabBarController<UITabBarControllerDelegate,ClassInfoViewDelegate>
{
    UIImageView* tabBarArrow;
    NSString* courseId;
    NSString* classId;
    NSString *token;
}
@property int tag;
@property (nonatomic, retain) UIImageView* tabBarArrow;
@property (nonatomic, retain) NSString* courseId;
@property (nonatomic, retain) NSString* classId;
@property (nonatomic, retain) NSString *token;
@end
