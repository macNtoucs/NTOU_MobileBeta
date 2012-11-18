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
@synthesize tabBarArrow;

- (id)init:(NSArray*)data
{
    self = [super init];
    if (self) {
        K_TimeView* view1,*view2,*view3;
        view1 = [[K_TimeView alloc] initWithStyle:UITableViewStyleGrouped];
        view1.title = K_TimeViewtype1;
        view1.data = [[data objectAtIndex:1] mutableCopy];
        view2 = [[K_TimeView alloc] initWithStyle:UITableViewStyleGrouped];
        view2.title = K_TimeViewtype2;
        view2.data = [[data objectAtIndex:2] mutableCopy];
        view2.data2 = [[data objectAtIndex:3] mutableCopy];
        view3 = [[K_TimeView alloc] initWithStyle:UITableViewStyleGrouped];
        view3.title = K_TimeViewtype3;
        view3.data = [[data objectAtIndex:4] mutableCopy];
        [self setViewControllers:[NSArray arrayWithObjects:view1, view2,view3, nil] animated:YES];
        self.delegate=self;
        [self addTabBarArrow];
        // Custom initialization
    }
    return self;
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
