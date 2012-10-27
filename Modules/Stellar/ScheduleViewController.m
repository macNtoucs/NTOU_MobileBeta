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
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    scrollView = [[[UIScrollView alloc] init]autorelease];
    weekschedule = [[[WeekScheduleView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    threedays_weekschedule = [[[threedays_WeekScheduleView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];

    [scrollView setFrame:[[UIApplication sharedApplication] keyWindow].frame];
    [scrollView addSubview:weekschedule];
    isWeekScheduleInScrowView = true;
    scrollView.delegate=self;
    scrollView.contentSize = CGSizeMake(370, 940);
    scrollView.bounces = NO;
    CGPoint center ;
    center.y=55;
    center.x=0;
    scrollView.contentOffset = scrollView_position = center;
    [self.view addSubview:scrollView];
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [scrollView addGestureRecognizer:pinchRecognizer];
    
    [weekschedule retain];
    [threedays_weekschedule retain];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    static CGPoint movement;
    movement.x += scrollView.contentOffset.x - scrollView_position.x;
    movement.y += scrollView.contentOffset.y - scrollView_position.y;
    if (isWeekScheduleInScrowView){
    scrollView_position.x = scrollView.contentOffset.x;
    scrollView_position.y = scrollView.contentOffset.y;
    LeftViewController.transform = CGAffineTransformMakeTranslation(0, -movement.y);
    TopWeekcontroller.transform = CGAffineTransformMakeTranslation(-movement.x, 0);
    }
    else{
        scrollView_position.x = scrollView.contentOffset.x;
        scrollView_position.y = scrollView.contentOffset.y;
        threedays_leftView.transform = CGAffineTransformMakeTranslation(0, -movement.y);
        threedays_topweekController.transform = CGAffineTransformMakeTranslation(-movement.x, 0);
    }
}

-(void)scale:(UIPinchGestureRecognizer *)gesture{
    if([gesture state] == UIGestureRecognizerStateEnded) {
         [self.navigationController setNavigationBarHidden:YES];
         [self.navigationController setNavigationBarHidden:NO];
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)gesture scale]);
    //NSLog(@"scale = %f ",scale);
    if (scale < 1 && !isWeekScheduleInScrowView){
        [threedays_leftView removeFromSuperview];
        [threedays_topweekController removeFromSuperview];
        [threedays_weekschedule removeFromSuperview];
        
        [self.navigationController.view  addSubview:TopWeekcontroller];
        [self.navigationController.view  addSubview:LeftViewController];
        [scrollView addSubview:weekschedule];
        isWeekScheduleInScrowView = true;
    }
    else if (scale >1 && isWeekScheduleInScrowView){
        [weekschedule removeFromSuperview];
        [LeftViewController removeFromSuperview];
        [TopWeekcontroller removeFromSuperview];
        
        [scrollView addSubview:threedays_weekschedule];
        [self.navigationController.view addSubview:threedays_topweekController];
        [self.navigationController.view  addSubview:threedays_leftView];
        isWeekScheduleInScrowView = false;
    
    }
    lastScale = [gesture scale];

}

/*
-(void)handleGesture:(UISwipeGestureRecognizer *)gesture{
    
    if (scrollView.contentOffset.y<350){
        if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
            scrollView.scrollEnabled = NO;
            scrollView.contentOffset = CGPointMake(264,55);
            }
        if (gesture.direction == UISwipeGestureRecognizerDirectionRight ){
            scrollView.scrollEnabled = NO;
            scrollView.contentOffset = CGPointMake(0,55);
            }
        }
    else{
        if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
            scrollView.scrollEnabled = NO;
            scrollView.contentOffset = CGPointMake(264,440);
        }
        if (gesture.direction == UISwipeGestureRecognizerDirectionRight ){
            scrollView.scrollEnabled = NO;
            scrollView.contentOffset = CGPointMake(0,440);
        }
        
    }
     if (gesture.direction == UISwipeGestureRecognizerDirectionUp){
     scrollView.contentOffset = CGPointMake(0,240);
     }
     if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
     scrollView.contentOffset = CGPointMake(0,-240);
     }
    scrollView.scrollEnabled = YES;
}

*/

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
