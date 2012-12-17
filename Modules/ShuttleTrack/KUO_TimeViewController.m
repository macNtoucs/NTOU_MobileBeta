//
//  KUO_TimeViewController.m
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import "KUO_TimeViewController.h"

@interface KUO_TimeViewController ()

@end

@implementation KUO_TimeViewController
@synthesize data;
@synthesize tabBarArrow;
@synthesize delegate2;
-(void)changeDirect
{
    [delegate2 TimeViewControllerDirectChange];
    [self setView];
}

-(void)setView
{
    K_TimeView* view1,*view2,*view3;
    view1 = [[K_TimeView alloc] initWithStyle:UITableViewStyleGrouped];
    view1.title = [delegate2 changeTimeViewTittle:K_TimeViewtype1];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:K_TimeViewtype1 image:[UIImage imageNamed:@"Time.png"] tag:1];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"Time.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"Time.png"]];
    view1.tabBarItem = item1;
    [item1 release];
    view1.data = [delegate2 checkExceptionArriveTime:[[data objectAtIndex:1] mutableCopy]];
    view1.delegate = self;
    
    view2 = [[K_TimeView alloc] initWithStyle:UITableViewStyleGrouped];
    view2.title = [delegate2 changeTimeViewTittle:K_TimeViewtype2];;
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:K_TimeViewtype2 image:[UIImage imageNamed:@"Info.png"] tag:2];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"Info.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"Info.png"]];
    view2.tabBarItem = item2;
    [item2 release];
    view2.data = [[data objectAtIndex:2] mutableCopy];
    view2.data2 = [[data objectAtIndex:3] mutableCopy];
    view2.delegate = self;
    
    view3 = [[K_TimeView alloc] initWithStyle:UITableViewStyleGrouped];
    view3.title = [delegate2 changeTimeViewTittle:K_TimeViewtype3];;
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:K_TimeViewtype3 image:[UIImage imageNamed:@"money-icon.png"] tag:3];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"money-icon.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"money-icon.png"]];
    view3.tabBarItem = item3;
    [item3 release];
    view3.data = [[data objectAtIndex:4] mutableCopy];
    view3.delegate = self;
    if (!self.viewControllers) {
        [self.viewControllers release];
    }
    [self setViewControllers:[NSArray arrayWithObjects:view1, view2,view3, nil] animated:YES];
}
- (id)init:(NSArray*)array delegate:(id)dele
{
    self = [super init];
    if (self) {
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"往返切換"
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(changeDirect)];
        self.data = array;
        self.delegate2 = dele;
        [self setView];
        [self.navigationItem setRightBarButtonItem:rightButton];
        self.delegate=self;
        [self addTabBarArrow];
        // Custom initialization
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:18.0];
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        titleView.textColor = [UIColor whiteColor]; // Change to desired color
        titleView.lineBreakMode = UILineBreakModeWordWrap;
        titleView.numberOfLines = 1;
        self.navigationItem.titleView = titleView;
        [titleView release];
    }
    titleView.text = title;
    [titleView sizeToFit];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
