//
//  StationView.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/6.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import <QuartzCore/QuartzCore.h>
#import "UIKit+MITAdditions.h"
#import "MITUIConstants.h"
#define type1 @"起站"
#define type3 @"時間"
#define type4 @"車種"
#define type2 @"訖站" 
#define type5 @"查詢"
@interface StationView : UITableViewController{
    int types;
}

@end
