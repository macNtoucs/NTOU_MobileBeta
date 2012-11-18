//
//  K_TimeView.h
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import <UIKit/UIKit.h>
#import "UIKit+MITAdditions.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#define K_TimeViewtype1 @"發車時間"
#define K_TimeViewtype2 @"中途停靠站"
#define K_TimeViewtype3 @"全程票價"
@interface K_TimeView : UITableViewController{
    NSArray* data;
    NSArray* data2;
}

@property (retain,nonatomic) NSArray* data;
@property (retain,nonatomic) NSArray* data2;
@end
