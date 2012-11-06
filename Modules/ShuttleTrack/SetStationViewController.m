//
//  SetStationViewController.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/6.
//
//

#import "SetStationViewController.h"

@interface SetStationViewController ()

@end

@implementation SetStationViewController
@synthesize tabBarArrow;
@synthesize tag;
@synthesize viewControllers;
@synthesize region;
@synthesize  nowSelectedRegion;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ThroughTap *bg = [[ThroughTap alloc]initWithFrame:CGRectMake(0,0,320,480)];
       
      [self addSelectView];
        region = [[NSArray alloc] initWithObjects:@"台北", @"桃園",@"新竹",@"苗栗",nil];
        UIViewController *setStartStationController,
                         *setdepatureStationviewController,
                         *setTimeviewController,
                         *setTrainTypeviewController,
                         *resultViewController;
        setStartStationController = [[UIViewController alloc] init];
        setStartStationController.title = @"起站";
        setdepatureStationviewController = [[UIViewController alloc] init];
        setdepatureStationviewController.title = @"訖站";
        setTimeviewController = [[UIViewController alloc] init];
        setTimeviewController.title = @"時間";
        setTrainTypeviewController = [[UIViewController alloc] init];
        setTrainTypeviewController.title = @"車種";
        resultViewController = [[UIViewController alloc] init];
        resultViewController.title = @"查詢";
       
        
        view1 = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(2.5, 5, 160, 320)];
        _view1 = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(157.5, 5, 160, 420)];
        [setStartStationController.view addSubview:view1];
        [setStartStationController.view addSubview:_view1];
        [setStartStationController.view addSubview:bg];
        view1.delegate = self;
        view1.dataSource = self;
        [view1 reloadData];
        ///////////////////////////////////////////////////////////
        view2 = [[StationPickerPickerView alloc] init];
        view2.frame = CGRectMake(0, 10, 320, 420);
        [setdepatureStationviewController.view addSubview:view2];
        view3 = [[StationView alloc] initWithStyle:UITableViewStyleGrouped];
        view3.title = type3;
        view3.view.frame = CGRectMake(0, 10, 320, 420);
        [setTimeviewController.view addSubview:view3.tableView];
        view4 = [[StationView alloc] initWithStyle:UITableViewStyleGrouped];
        view4.title = type4;
        view4.view.frame = CGRectMake(0, 10, 320, 420);
        [setTrainTypeviewController.view addSubview:view4.tableView];
        view5 = [[StationView alloc] initWithStyle:UITableViewStyleGrouped];
        view5.title = type5;
        view5.view.frame = CGRectMake(0, 10, 320, 420);
        [resultViewController.view addSubview:view5.tableView];
        
        viewControllers = [[NSArray alloc]initWithObjects:setStartStationController, setdepatureStationviewController,setTimeviewController,setTrainTypeviewController ,resultViewController,nil];
        
      [self setViewControllers:viewControllers animated:YES];
        self.delegate=self;
       
        view2.delegate = self;
       
        view2.dataSource = self;
        view1.rowFont = [UIFont boldSystemFontOfSize:19.0];
        view1.rowIndent = 10.0;
        [self addTabBarArrow];
    }
    self.tabBar.frame = CGRectMake(0, 480-self.tabBar.frame.size.height-20, self.tabBar.frame.size.width, self.tabBar.frame.size.height+20);
   
    return self;
}


-(void) addSelectView{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(160,140, 160, 60)];
    //sampleView.backgroundColor = [UIColor whiteColor];
    whiteView.backgroundColor = [UIColor clearColor];
    whiteView.alpha=0.25;
    whiteView.layer.cornerRadius = 2.5; // 圓角的弧度
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.shadowColor = [[UIColor blackColor] CGColor];
    whiteView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    whiteView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    whiteView.layer.shadowRadius = 10.0f; // 陰影發散的程度
    whiteView.layer.borderWidth = 1;
    whiteView.layer.borderColor = [[UIColor blackColor] CGColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = whiteView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor grayColor] CGColor], nil]; // 由上到下的漸層顏色
    [whiteView.layer insertSublayer:gradient atIndex:0];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(10,140, 150, 60)];
    blueView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:128.0/255.0 alpha:0.3];
    blueView.layer.cornerRadius = 2.5; // 圓角的弧度
    blueView.layer.masksToBounds = YES;
    blueView.layer.shadowColor = [[UIColor blackColor] CGColor];
    blueView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    blueView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    blueView.layer.shadowRadius = 10.0f; // 陰影發散的程度
    blueView.layer.borderWidth = 1;
    blueView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:whiteView];
    [self.view addSubview:blueView];
  
    
}
- (NSString *)pickerView:(StationPickerPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == view1)
        return [region objectAtIndex:row];
    
}

- (NSInteger)numberOfRowsInPickerView:(StationPickerPickerView *)pickerView
{
    if (pickerView == view1)
        return [region count];
}

- (void)pickerView:(StationPickerPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView == view1)
      
     NSLog(@"%@",[region objectAtIndex:row]);
    
}

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.tabBar.frame.size.width / self.tabBar.items.count;
    CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
    return (tabIndex * tabItemWidth) + halfTabItemWidth;
}
- (void) addTabBarArrow
{
    UIImage* tabBarArrowImage = [UIImage imageNamed:@"TabBarNipple@2x.png"];
    self.tabBarArrow = [[[UIImageView alloc] initWithImage:tabBarArrowImage] autorelease];
    CGFloat verticalLocation = 340;
    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], verticalLocation, tabBarArrowImage.size.width, tabBarArrowImage.size.height);
    
    [self.view addSubview:tabBarArrow];
}


- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = tabBarArrow.frame;
    frame.origin.x = [self horizontalLocationFor:self.selectedIndex];
    tabBarArrow.frame = frame;
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end