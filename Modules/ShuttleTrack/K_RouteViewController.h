//
//  K_RouteViewController.h
//  MIT Mobile
//
//  Created by mini server on 12/11/16.
//
//

#import <UIKit/UIKit.h>
#import "Kuo_Data.h"
#import "KUO_KUANGViewController.h"
@interface K_RouteViewController : UITableViewController{
    int region;
    Kuo_Data* data;
    NSMutableArray* titleArray;
    UISearchBar *MySearchBar;
    BOOL issearching; 
}
@property int region;
@end
