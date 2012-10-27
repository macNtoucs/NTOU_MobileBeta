//
//  ScheduleViewController.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController
@synthesize  UpperleftView;
@synthesize  scrollView;
@synthesize  TopWeekcontroller;
@synthesize LeftViewController;
@synthesize weekschedule;
@synthesize threedays_leftView;
@synthesize threedays_topweekController;
@synthesize threedays_weekschedule;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        TopWeekcontroller = [[WeekNameView alloc] initWithFrame:CGRectMake(30, 64, 320, 40)];
        threedays_topweekController = [[threedays_WeekNameView alloc] initWithFrame:CGRectMake(30, 64, 320, 40)];
        LeftViewController  = [[LessonTimeView alloc]initWithFrame:CGRectMake(0, 49, 30, 740)];
        threedays_leftView = [[threedays_LessonTimeView alloc]initWithFrame:CGRectMake(0, 49, 30, 740)];
        UpperleftView = [[UIView alloc] initWithFrame:CGRectMake(0,64, 30, 40)];
        UpperleftView.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        UpperleftView.layer.borderWidth = 2.0f;
        UpperleftView.layer.borderColor = [UIColor blackColor].CGColor;
        
        
        
    }
    return self;
}
-(void) addNavRightButton {
    UIToolbar *tools = [[UIToolbar alloc]
                        initWithFrame:CGRectMake(0.0f, 0.0f, 103.0f, 44.01f)]; // 44.01 shifts it up 1px for some reason
    tools.clearsContextBeforeDrawing = NO;
    tools.clipsToBounds = NO;
    tools.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f]; // closest I could get by eye to black, translucent style.
    // anyone know how to get it perfect?
    tools.barStyle = -1; // clear background
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    // Create a standard refresh button.
    UIBarButtonItem *bi = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(refresh:)];
    [buttons addObject:bi];
    [bi release];
    
    bi = [[UIBarButtonItem alloc]
           initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(refresh:)];
    [buttons addObject:bi];
    [bi release];
    // Add profile button.
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(refresh:)];
    [buttons addObject:bi];
    [bi release];

    
    // Add buttons to toolbar and toolbar to nav bar.
    [tools setItems:buttons animated:NO];
    [buttons release];
    UIBarButtonItem *twoButtons = [[UIBarButtonItem alloc] initWithCustomView:tools];
    [tools release];
    self.navigationItem.rightBarButtonItem = twoButtons;
    [twoButtons release];
}

- (void)viewDidLoad
{

    scrollView = [[[UIScrollView alloc] init]autorelease];
    weekschedule = [[[WeekScheduleView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    
    [self addNavRightButton]; 
    scrollView = [[UIScrollView alloc] init];
   
    [scrollView setFrame:[[UIApplication sharedApplication] keyWindow].frame];
    [scrollView addSubview:weekschedule];
    isWeekScheduleInScrowView = true;
    scrollView.delegate=self;
    scrollView.contentSize = CGSizeMake(378, 940);
    scrollView.bounces = NO;
    CGPoint center ;
    center.y=55;
    center.x=0;
    scrollView.contentOffset = scrollView_position = center;
    [self.view addSubview:scrollView];
    [scrollView release];

    [super viewDidLoad];
	
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    static CGPoint movement;
    movement.x += scrollView.contentOffset.x - scrollView_position.x;
    movement.y += scrollView.contentOffset.y - scrollView_position.y;


    scrollView_position.x = scrollView.contentOffset.x;
    scrollView_position.y = scrollView.contentOffset.y;
    LeftViewController.transform = CGAffineTransformMakeTranslation(0, -movement.y);
    TopWeekcontroller.transform = CGAffineTransformMakeTranslation(-movement.x, 0);
   }



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.view addSubview:LeftViewController];
    [self.navigationController.view addSubview:TopWeekcontroller];
    [self.navigationController.view addSubview:UpperleftView];
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [TopWeekcontroller removeFromSuperview];
    [LeftViewController removeFromSuperview];
    [UpperleftView removeFromSuperview];
    [threedays_leftView removeFromSuperview];
    [threedays_topweekController removeFromSuperview];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [UpperleftView release];
    [TopWeekcontroller release];
    [LeftViewController removeFromSuperview];
    [super dealloc];
}

@end
