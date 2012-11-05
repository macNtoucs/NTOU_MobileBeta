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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      /*  ClassLabelBasis * classinfo = [[[ClassLabelBasis alloc] initWithFrame:CGRectMake(100, 0, 320, 40)] autorelease];
        classinfo.backgroundColor = [UIColor clearColor];
        classinfo.text = [NSString stringWithFormat:@"設定起站"];
        classinfo.font = [UIFont fontWithName:@"AppleGothic" size:15];
        classinfo.lineBreakMode = UILineBreakModeWordWrap;
        classinfo.numberOfLines = 0;
        [self.view addSubview:classinfo];*/
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
        StationView *view1, *view2, *view3, *view4, *view5;
        view1 = [[StationView alloc] initWithStyle:UITableViewStyleGrouped];
        view1.title = type1;
        view1.view.frame = CGRectMake(0, 10, 320, 420);
        [setStartStationController.view addSubview:view1.tableView];
        view2 = [[StationView alloc] initWithStyle:UITableViewStyleGrouped];
        view2.title = type2;
        view2.view.frame = CGRectMake(0, 10, 320, 420);
        [setdepatureStationviewController.view addSubview:view2.tableView];
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
        [self addTabBarArrow];
    }
    return self;
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
    CGFloat verticalLocation = 357;
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