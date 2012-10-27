//
//  StopsViewController.h
//  MIT Mobile
//
//  Created by mac_hero on 12/9/27.
//
//

#import <UIKit/UIKit.h>
#import "RouteDetailViewController.h"
@interface StopsViewController : UITableViewController{
    bool go;  //true 往市區, false 往八斗子
}
-(void) setDirection :(BOOL) dir;
@end
