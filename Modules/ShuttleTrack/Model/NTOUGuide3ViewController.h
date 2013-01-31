//
//  NTOUGuide3ViewController.h
//  NTOUMobile
//
//  Created by cclin on 1/31/13.
//
//

#import <UIKit/UIKit.h>
#import "NTOUGuideSetViewController.h"
@interface NTOUGuide3ViewController : UITableViewController{
    int WhatRoute;
}
-(void) SetRoute:(int)RouteNumber;
@end
