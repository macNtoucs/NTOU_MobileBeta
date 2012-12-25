#import "CKViewController.h"
#import "CKCalendarView.h"


@interface CKViewController ()


@property(nonatomic, retain) CKCalendarView* calendar;

@end

@implementation CKViewController

@synthesize calendar;
@synthesize selectedDate;

- (id)init {
    self = [super init];
    if (self) {
        selectedDate = [NSDate new];
        [self didSelectDate:selectedDate];
        self.view.backgroundColor = [UIColor grayColor];
        
        // init calendar view;
        calendar = [[CKCalendarView alloc] initWithStartDay:startMonday frame:CGRectMake(0, 0, 320, 320)];
        calendar.delegate = self;
        
        [self.view addSubview:calendar];
       
       

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark CKViewDelegate Methods

- (void)didSelectDate:(NSDate *)date
{
        
    //取得國際時間的timeZone，這個時區為sourceTimeZone
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    //取得當地的時區，我稱為destinationTimeZone
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    //算出國際時間的時區，和原本時間的時區差了多少，記錄在sourceGMTOffset
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    
    //算出當地際時間的時區，和原本時間的時區差了多少，記錄在destinationGMTOffset
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    
    //在算出兩者的差距
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    //依差距，把原本以國際標準時間存成的NSDate，轉成新的NSDate
    selectedDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date] ;
    NSLog(@"Now selected date : %@",selectedDate);
    
    
}


@end
