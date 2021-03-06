//
//  ClassInfoViewController.m
//  MIT Mobile
//
//  Created by mini server on 12/11/3.
//
//

#import "ClassInfoViewController.h"
#import "ClassDataBase.h"
@interface ClassInfoViewController (){
    ClassLabelBasis * classinfo;
    ClassInfoView * view5;
}

@end

@implementation ClassInfoViewController
@synthesize classId;
@synthesize courseId;
@synthesize tag;
@synthesize tabBarArrow;
@synthesize token;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
        }
    
    return self;
}

-(void)presentOn:(ReaderViewController*)ViewController
{
    ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    ViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:ViewController animated:YES completion:nil];
}
-(void)presentOff
{
    [self dismissModalViewControllerAnimated:YES];
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
    CGFloat verticalLocation = [[UIScreen mainScreen] bounds].size.height-tabBarArrowImage.size.height-self.tabBar.frame.size.height-[[UIApplication sharedApplication] statusBarFrame].size.height-44+5;;
    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], verticalLocation, tabBarArrowImage.size.width, tabBarArrowImage.size.height);
    
    [self.view addSubview:tabBarArrow];
}

-(void)Task
{
    UIViewController *viewController = [self.viewControllers objectAtIndex:1];
    [viewController.view removeAllSubviews];
    ClassInfoView *view = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
    if (self.navigationItem.rightBarButtonItem.title == type6) {
        self.navigationItem.rightBarButtonItem.title = @"上課講義";
        view.title = type6;
        viewController.title = type6;
        classinfo.text = type6;
    }
    else{
        self.navigationItem.rightBarButtonItem.title = type6;
        view.title = type4;
        viewController.title = type4;
        classinfo.text = @"上課講義";
    }
    view.view.frame = CGRectMake(0, 40, 320, 330);
    NSDictionary* apiKey = [[ClassDataBase sharedData] loginCourseToGetCourseidAndClassid:self.title];
    view.moodleData = [Moodle_API GetMoodleInfo_AndUseToken:token courseID:[apiKey objectForKey:courseIDKey] classID:[apiKey objectForKey:classIDKey]];
    if (!view.moodleData) {
        token = [[ClassDataBase sharedData] loginTokenWhenAccountFromUserDefault];
        view.moodleData = [Moodle_API GetMoodleInfo_AndUseToken:token courseID:[apiKey objectForKey:courseIDKey] classID:[apiKey objectForKey:classIDKey]];
        if (!view.moodleData) {
            UIAlertView *loadingAlertView = [[UIAlertView alloc]
                                             initWithTitle:nil message:@"網路連線失敗"
                                             delegate:self cancelButtonTitle:@"確定"
                                             otherButtonTitles:nil];
            [loadingAlertView show];
            [loadingAlertView release];
        }
    }
    [viewController.view addSubview:view.tableView];
}

-(void)changeType{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD showWhileExecuting:@selector(Task) onTarget:self withObject:nil animated:YES];
}

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = tabBarArrow.frame;
    frame.origin.x = [self horizontalLocationFor:self.selectedIndex];
    tabBarArrow.frame = frame;
    [UIView commitAnimations];
    if (self.selectedIndex==1) {
        UIBarButtonItem *rightButton;
        classinfo.font = [UIFont fontWithName:BOLD_FONT size:20];
        if ([[self.viewControllers objectAtIndex:1] title]==type6) {
            classinfo.text = [NSString stringWithFormat:type6];
            rightButton= [[UIBarButtonItem alloc] initWithTitle:@"上課講義"
                                               style:UIBarButtonItemStyleBordered
                                              target:self
                                                         action:@selector(changeType)];
        } else {
            classinfo.text = [NSString stringWithFormat:@"上課講義"];
            rightButton= [[UIBarButtonItem alloc] initWithTitle:type6
                                                          style:UIBarButtonItemStyleBordered
                                                         target:self
                                                         action:@selector(changeType)];
        }
        [self.navigationItem setRightBarButtonItem:rightButton];
    }
    else{
        [self.navigationItem setRightBarButtonItem:nil];
        classinfo.text = nil;
        if (self.selectedIndex==0){
            classinfo.font = [UIFont fontWithName:BOLD_FONT size:15];
            classinfo.text = [NSString stringWithFormat:@"教授名稱：%@\n 教室地點：%@",[[ClassDataBase sharedData] FetchProfessorName:[NSNumber numberWithInt:self.tag]],[[ClassDataBase sharedData] FetchClassroomLocation:[NSNumber numberWithInt:self.tag]]];
        }
    }
    
}


- (void)leaveEditMode {
    [view5.textView resignFirstResponder];
}

-(void)rightBarButtonItemOn{
    UIBarButtonItem *done =    [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leaveEditMode)] autorelease];
    
    self.navigationItem.rightBarButtonItem = done;
    view5.view.frame = CGRectMake(0, 10, 320, [[UIScreen mainScreen] bounds].size.height-280);
}
-(void)rightBarButtonItemOff{
    self.navigationItem.rightBarButtonItem = nil;
    view5.view.frame = CGRectMake(0, 10, 320, [[UIScreen mainScreen] bounds].size.height-30);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.viewControllers) {
        NSDictionary* apiKey = [[ClassDataBase sharedData] loginCourseToGetCourseidAndClassid:self.title];
        UIViewController *viewController1, *viewController2, *viewController3, *viewController4, *viewController5;
        viewController1 = [[UIViewController alloc] init];
        viewController1.title = type3;
        viewController2 = [[UIViewController alloc] init];
        viewController2.title = type4;
        viewController3 = [[UIViewController alloc] init];
        viewController3.title = type2;
        viewController4 = [[UIViewController alloc] init];
        viewController4.title = type1;
        viewController5 = [[UIViewController alloc] init];
        viewController5.title = type5;
        
        ClassInfoView *view1, *view2, *view3, *view4;
        view1 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view1.title = type3;
        NSArray* listData = [[Moodle_API GetMoodleInfo_AndUseToken:token courseID:[apiKey objectForKey:courseIDKey] classID:[apiKey objectForKey:classIDKey]] objectForKey:moodleListKey];
        NSArray* data = [[NSArray alloc] init];
        if ([listData count]) {
            data = [[listData objectAtIndex:0] objectForKey:moodleResourceInfoKey];
        }
        data = [[data reverseObjectEnumerator] allObjects];
        NSMutableArray* resource = [[NSMutableArray alloc] init];
        for (NSDictionary* info in data) {
            [resource addObject:[Moodle_API GetMoodleInfo_AndUseToken:token
                                                               module:[info objectForKey:moodleResourceModuleKey]
                                                                  mid:@" "
                                                             courseID:[apiKey objectForKey:courseIDKey]
                                                              classID:[apiKey objectForKey:classIDKey]]];
        }
        
        view1.delegatetype5 = self;
        view1.resource = resource;
        view1.view.frame = CGRectMake(0, 40, 320, [[UIScreen mainScreen] bounds].size.height-60);
        [viewController1.view addSubview:view1.tableView];
        
        view2 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view2.title = type4;
        view2.delegatetype5 = self;
        view2.moodleData = [Moodle_API GetMoodleInfo_AndUseToken:token courseID:[apiKey objectForKey:courseIDKey] classID:[apiKey objectForKey:classIDKey]];
        view2.view.frame = CGRectMake(0, 40, 320, [[UIScreen mainScreen] bounds].size.height-60);
        [viewController2.view addSubview:view2.tableView];
        
        view3 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view3.title = type2;
        view3.moodleData = [Moodle_API GetGrade_AndUseToken:token courseID:[apiKey objectForKey:courseIDKey] classID:[apiKey objectForKey:classIDKey]];
        view3.delegatetype5 = self;
        view3.view.frame = CGRectMake(0, 10, 320, [[UIScreen mainScreen] bounds].size.height-30);
        [viewController3.view addSubview:view3.tableView];
        
        view4 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view4.title = type1;
        view4.moodleData = [Moodle_API GetGrade_AndUseToken:token courseID:[apiKey objectForKey:courseIDKey] classID:[apiKey objectForKey:classIDKey]];
        view4.delegatetype5 = self;
        view4.view.frame = CGRectMake(0, 10, 320, [[UIScreen mainScreen] bounds].size.height-30);
        [viewController4.view addSubview:view4.tableView];
        
        view5 = [[ClassInfoView alloc] initWithStyle:UITableViewStyleGrouped];
        view5.delegatetype5 = self;
        view5.moodleData = apiKey;
        view5.title = type5;
        view5.view.frame = CGRectMake(0, 10, 320, [[UIScreen mainScreen] bounds].size.height-30);
        [viewController5.view addSubview:view5.tableView];
        
        [self setViewControllers:[NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4,viewController5, nil] animated:YES];
        self.delegate=self;
        self.view.backgroundColor = [UIColor clearColor];
        [self addTabBarArrow];
    }
    
    if (!classinfo) {
        classinfo = [[[ClassLabelBasis alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
        classinfo.backgroundColor = [UIColor clearColor];
        classinfo.textAlignment = UITextAlignmentCenter;
        classinfo.font = [UIFont fontWithName:BOLD_FONT size:15];
        classinfo.lineBreakMode = UILineBreakModeWordWrap;
        classinfo.numberOfLines = 0;
        ClassDataBase* ClassData = [ClassDataBase sharedData];
        classinfo.text = [NSString stringWithFormat:@"教授名稱：%@\n 教室地點：%@",[ClassData FetchProfessorName:[NSNumber numberWithInt:self.tag]],[ClassData FetchClassroomLocation:[NSNumber numberWithInt:self.tag]]];
    }
    [self.view addSubview:classinfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
}


@end
