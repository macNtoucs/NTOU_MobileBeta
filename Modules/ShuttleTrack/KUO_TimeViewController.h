//
//  KUO_TimeViewController.h
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//
@protocol KUO_TimeViewControllerDelegate <NSObject>
@required
-(void)TimeViewControllerDirectChange;
@end
#import <UIKit/UIKit.h>
#import "K_TimeView.h"
@interface KUO_TimeViewController : UITabBarController<UITabBarControllerDelegate,K_TimeViewDelegate>{
    UIImageView* tabBarArrow;
    NSArray* data;
    id delegate2;
}
@property(retain,nonatomic) UIImageView* tabBarArrow;
@property(retain,nonatomic) NSArray* data;
@property (nonatomic,assign) id delegate2;
- (id)init:(NSArray*)array;
@end
