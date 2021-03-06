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
@synthesize toolbar = _toolbar;

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
        //self.title= @"Location";
    }
   
    return self;
}

-(NSString *)LabelText
{
    NSLog(@"%@",self.title);
    if ([self.title isEqualToString: @"松山車站"]) {
        return @"乘車地點：肯德基門口前1061站牌";
    }
    else if ([self.title isEqualToString: @"饒河街口"]){
        return @"乘車地點：八德停車場對面";
    }
    else if ([self.title isEqualToString:@"京華城" ]){
    return @"乘車地點：八德消防隊斜對面";
}
    else if ([self.title isEqualToString: @"監理處"]){
    return @"乘車地點：池上便當前";
}
    else if ([self.title isEqualToString:@"美仁里" ]){
    return @"乘車地點：天仁茶行前";
}
    else if ([self.title isEqualToString: @"臺安醫院"]){
    return @"乘車地點：總督戲城旁";
}
    else if ([self.title isEqualToString: @"捷運忠孝復興站"]){
    return @"乘車地點：西提牛排前";
}
    else if ([self.title isEqualToString: @"啟聰學校"]){
    return @"乘車地點：啟聰學校旁";
}
    else if ([self.title isEqualToString: @"酒泉街"]){
        return @"乘車地點：東方美早餐前";
    }
    else if ([self.title isEqualToString: @"市立美術館"]){
        return @"乘車地點：中山北路市立美術館前";
    }
    else if ([self.title isEqualToString: @"捷運劍潭站"]){
        return @"乘車地點：士林夜市對面";
    }
    else if ([self.title isEqualToString: @"士林行政中心"]){
        return @"乘車地點：特力屋對面";
    }
    else if ([self.title isEqualToString: @"工學院"]){
        return @"乘車地點：資工系館前";
    }
    else if ([self.title isEqualToString: @"祥豐校區站"]){
        return @"乘車地點：環資系館";
    }
    else if ([self.title isEqualToString: @"人社院站"]){
        return @"乘車地點：綜合研究中心";
    }
    return nil;
}


-(void)loadView
{
    [super loadView];
        
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
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-44, 320, 44)];
    self.toolbar.barStyle = UIBarButtonItemStyleBordered;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 20.0f)];
    label.text = [self LabelText];
    label.font = [label.font fontWithSize:20];
    label.userInteractionEnabled = NO;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:1.f];
    label.shadowColor = [UIColor colorWithWhite:1.f alpha:.5f];
    UIBarButtonItem *statusItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.toolbar.items = [NSArray arrayWithObject: statusItem];
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
    [self.navigationController.view addSubview:self.toolbar];
    [self.view addSubview:mapView];
    [mapView release];

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

- (void)viewWillDisappear:(BOOL)animated
{
    [self.toolbar removeFromSuperview];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
