//
//  NTOUGuide2ViewController.h
//  NTOUMobile
//
//  Created by cclin on 1/24/13.
//
//

#import <UIKit/UIKit.h>
#import "NTOUGuideSetViewController.h"
@interface NTOUGuide2ViewController : UITableViewController{
    int WhatRoute;
}
-(void) SetRoute:(int)RouteNumber;
@end
