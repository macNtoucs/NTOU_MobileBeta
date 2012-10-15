//
//  StopsLocationViewController.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/1.
//
//
#import "Annotation.h"
#import <UIKit/UIKit.h>

@interface StopsLocationViewController : UIViewController{
CLLocationCoordinate2D location;
MKCoordinateSpan span;
MKMapView *mapView;
    UIBarButtonItem *switchButton;
    UIToolbar *toolbar;

}
-(void) setlocation:(CLLocationCoordinate2D) inputloaction latitudeDelta:(double)latitude longitudeDelta:(double)longitude;
@property (nonatomic, retain) UIToolbar *toolbar;
@end
