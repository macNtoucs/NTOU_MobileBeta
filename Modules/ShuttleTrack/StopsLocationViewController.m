//
//  StopsLocationViewController.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/1.
//
//

#import "StopsLocationViewController.h"

@interface StopsLocationViewController ()

@end

@implementation StopsLocationViewController


-(void) setlocation:(CLLocationCoordinate2D) inputloaction latitudeDelta:(double)latitude longitudeDelta:(double)longitude{
    location = inputloaction;
    span.latitudeDelta  = latitude;
    span.longitudeDelta = longitude;
}

- (void)mapView:(MKMapView *)theMapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [theMapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}
-(void)addBusAnnotationNearLatitude :(double)latitude andLongtitude:(double)longtitude{
    
   
        [mapView addAnnotation:[[Annotation alloc] initWhithTitle:self.title
                                                         subTitle:nil
                                                    andCoordiante:location]];
    
}

-(id)init{
    self = [super init];
    if (self){
        self.title= @"Location";
    }
   
    return self;
}
-(void)loadView
{
    [super loadView];
    
    MKUserLocation *userlocation = [[MKUserLocation alloc]init];
    [userlocation setCoordinate:location];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    MKCoordinateRegion region;
    region.center.latitude = location.latitude;
    region.center.longitude = location.longitude;
    region.span = span;
    [self mapView:mapView didUpdateUserLocation:userlocation];
    [self addBusAnnotationNearLatitude :region.center.latitude andLongtitude:region.center.longitude];
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    [mapView setRegion:region animated:YES];
    
    [self.view addSubview:mapView];
    [mapView release];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadView];
    [super viewWillAppear:animated];
}
-(void)switchMapType{
    if (switchButton.title==@"切換衛星地圖")
    {
        mapView.mapType = MKMapTypeSatellite;
        switchButton.title =@"切換混合地圖";
    }
    else if (switchButton.title==@"切換標準地圖")
    {
        mapView.mapType = MKMapTypeStandard;
        switchButton.title =@"切換衛星地圖";
        
    }
    else if (switchButton.title==@"切換混合地圖")
    {
        mapView.mapType = MKMapTypeHybrid;
        switchButton.title =@"切換標準地圖";
    
    }
    [self reloadInputViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switchButton = [[UIBarButtonItem alloc] initWithTitle:@"切換衛星地圖" style:UIBarButtonItemStylePlain target:self action:@selector(switchMapType)];
    self.navigationItem.rightBarButtonItem = switchButton;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
