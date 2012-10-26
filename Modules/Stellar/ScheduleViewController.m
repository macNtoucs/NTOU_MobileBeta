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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        TopWeekcontroller = [[WeekNameView alloc] initWithFrame:CGRectMake(55, 64, 320, 40)];
        LeftViewController  = [[LessonTimeView alloc]initWithFrame:CGRectMake(0, 104, 55, 740)];
        UpperleftView = [[UIView alloc] initWithFrame:CGRectMake(0,64, 55, 40)];
        UpperleftView.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        UpperleftView.layer.borderWidth = 2.0f;
        UpperleftView.layer.borderColor = [UIColor blackColor].CGColor;
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setFrame:[[UIApplication sharedApplication] keyWindow].frame];
    [scrollView addSubview:[[[WeekScheduleView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease]];
    scrollView.contentSize = CGSizeMake(600, 940);
    scrollView.bounces = NO;
    CGPoint center ;
    center.y=58.5;
    center.x=0;
    scrollView.contentOffset = center;
    [self.view addSubview:scrollView];
    [scrollView release];
  
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.view addSubview:LeftViewController];
    [self.navigationController.view addSubview:TopWeekcontroller];
    [self.navigationController.view addSubview:UpperleftView];
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [TopWeekcontroller removeFromSuperview];
    [LeftViewController removeFromSuperview];
    [UpperleftView removeFromSuperview];
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
