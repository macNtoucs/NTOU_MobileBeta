//
//  NTOUGuideSetViewController.h
//  NTOUMobile
//
//  Created by cclin on 1/31/13.
//
//
#import "Annotation.h"
#import <UIKit/UIKit.h>

@interface NTOUGuideSetViewController : UIViewController{
    CLLocationCoordinate2D location;
    MKCoordinateSpan span;
    MKMapView *mapView;
    UIBarButtonItem *switchButton;

    
}
-(void) setlocation:(CLLocationCoordinate2D) inputloaction latitudeDelta:(double)latitude longitudeDelta:(double)longitude;




@end
