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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        TopWeekcontroller = [[WeekNameView alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
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
    [self.navigationController.view addSubview:TopWeekcontroller];
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [TopWeekcontroller removeFromSuperview];

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
