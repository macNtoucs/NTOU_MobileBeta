//
//  KUO_TimeViewController.h
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import <UIKit/UIKit.h>
#import "K_TimeView.h"
@interface KUO_TimeViewController : UITabBarController<UITabBarControllerDelegate>{
    UIImageView* tabBarArrow;
}
@property(retain,nonatomic) UIImageView* tabBarArrow;
- (id)init:(NSArray*)data;
@end
