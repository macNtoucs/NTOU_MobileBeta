//
//  KUO_RouteViewController_Bra2.h
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import <UIKit/UIKit.h>
#import "KUO_Data_Bra2.h"
#import "KUO_TimeViewController.h"
@interface KUO_RouteViewController_Bra2 : UITableViewController{
    KUO_Data_Bra2 * data;
    NSDictionary* display;
    NSMutableDictionary* inbound;
    NSMutableDictionary* outbound;
}

@end
