//
//  K_TimeView.h
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//
@protocol K_TimeViewDelegate <NSObject>

@required
-(void)changeDirect;
@end

#import <UIKit/UIKit.h>
#import "UIKit+MITAdditions.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#define K_TimeViewtype1 @"發車時間"
#define K_TimeViewtype2 @"停靠站"
#define K_TimeViewtype3 @"票價"
@interface K_TimeView : UITableViewController{
    NSArray* data;
    NSArray* data2;
    id delegate;
}
@property (nonatomic,assign) id delegate;
@property (retain,nonatomic) NSArray* data;
@property (retain,nonatomic) NSArray* data2;
@end
