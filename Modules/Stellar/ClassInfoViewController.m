//
//  ClassInfoViewController.m
//  MIT Mobile
//
//  Created by mini server on 12/11/3.
//
//

#import "ClassInfoViewController.h"

@interface ClassInfoViewController ()

@end

@implementation ClassInfoViewController
@synthesize tag;
@synthesize tabBarArrow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ClassLabelBasis * classinfo = [[[ClassLabelBasis alloc] initWithFrame:CGRectMake(100, 0, 320, 40)] autorelease];
        classinfo.backgroundColor = [UIColor clearColor];
        classinfo.text = [NSString stringWithFormat:@"教授名稱：林清池\n教室地點：CS301"];
        classinfo.font = [UIFont fontWithName:@"AppleGothic" size:15];
        classinfo.lineBreakMode = UILineBreakModeWordWrap;
        classinfo.numberOfLines = 0;
        [self.view addSubview:classinfo];
        UIViewController *viewController1, *viewController2, *viewController3, *viewController4, *viewController5;
        viewController1 = [[UIViewController alloc] init];
        viewController1.title = type1;
        viewController2 = [[UIViewController alloc] init];
        viewController2.title = type2;
        viewController3 = [[UIViewController alloc] init];
        viewController3.title = type3;
        viewController4 = [[UIViewController alloc] init];
        viewController4.title = type4;
        viewController5 = [[UIViewController alloc] init];
        viewController5.title = type5;
        ClassInfoView *view1, *view2, *view3, *view4, *view5;
        view1 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view1.title = type1;
        view1.view.frame = CGRectMake(0, 40, 320, 420);
        [viewController1.view addSubview:view1.tableView];
        view2 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view2.title = type2;
        view2.view.frame = CGRectMake(0, 40, 320, 420);
        [viewController2.view addSubview:view2.tableView];
        view3 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view3.title = type3;
        view3.view.frame = CGRectMake(0, 40, 320, 420);
        [viewController3.view addSubview:view3.tableView];
        view4 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view4.title = type4;
        view4.view.frame = CGRectMake(0, 40, 320, 420);
        [viewController4.view addSubview:view4.tableView];
        view5 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view5.title = type5;
        view5.view.frame = CGRectMake(0, 40, 320, 420);
        [viewController5.view addSubview:view5.tableView];
        [self setViewControllers:[NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4,viewController5, nil] animated:YES];
        self.delegate=self;
        [self addTabBarArrow];
    }
    
    return self;
}

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    // A single tab item's width is the entire width of the tab bar divided by number of items
    CGFloat tabItemWidth = self.tabBar.frame.size.width / self.tabBar.items.count;
    // A half width is tabItemWidth divided by 2 minus half the width of the arrow
    CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
    
    // The horizontal location is the index times the width plus a half width
    return (tabIndex * tabItemWidth) + halfTabItemWidth;
}

- (void) addTabBarArrow
{
    UIImage* tabBarArrowImage = [UIImage imageNamed:@"TabBarNipple@2x.png"];
    self.tabBarArrow = [[[UIImageView alloc] initWithImage:tabBarArrowImage] autorelease];
    // To get the vertical location we start at the bottom of the window, go up by height of the tab bar, go up again by the height of arrow and then come back down 2 pixels so the arrow is slightly on top of the tab bar.
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
