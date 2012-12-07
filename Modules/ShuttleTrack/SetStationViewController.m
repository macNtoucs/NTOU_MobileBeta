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
@synthesize region;
@synthesize  nowSelectedRegion;
@synthesize station;

-(id)initIsHighSpeedTrain:(bool)isHighSpeedTrain{
    ThroughTap *bg = [[ThroughTap alloc]initWithFrame:CGRectMake(0,0,320,480)];
    startStaion_origin =0;
    depatureStation_origin=0;
    dateSelected=0;
    queryDate = [NSString new];
    trainStyle = [[NSString alloc]initWithString:@"2"];
    isinitData = true;
    downloadView = [DownloadingView new];
    //[self addSelectView];
    [self createData];
    _isHightSpeedTrain = isHighSpeedTrain;
    if (!isHighSpeedTrain){
        startStaion = [[NSString alloc]initWithString:@"基隆"];
        DepatureStation = [[NSString alloc]initWithString:@"臺北"];
        view1 = [[SetOriginAndStationViewController alloc] initWithStyle:UITableViewStyleGrouped];
        view1.view.frame = CGRectMake(0, 0, 320, 440);
        [setStartStationController.view addSubview:view1.view];
        [setStartStationController.view addSubview:bg];
        setStartStationController.tabBarItem.tag=0;
        view1.delegate = self;
        setStartStationController.tabBarItem.image = [UIImage imageNamed:@"bank.png"];
        ///////////////////////////////////////////////////////////
        view2 = [[SetOriginAndStationViewController alloc] initWithStyle:UITableViewStyleGrouped];
        view2.view.frame = CGRectMake(0, 0, 320, 440);
        [setdepatureStationviewController.view addSubview:view2.view];
        [setdepatureStationviewController.view addSubview:bg];
        view2.delegate = self;
        setdepatureStationviewController.tabBarItem.tag=1;
        setdepatureStationviewController.tabBarItem.image = [UIImage imageNamed:@"bank.png"];
        ///////////////////////////////////////////////////////////
    }
    else{
        startStaion = [[NSString alloc]initWithString:@"台北"];
        DepatureStation = [[NSString alloc]initWithString:@"左營"];
        HTView_origin = [[setHTOriginAndTerminalViewController alloc] initWithStyle:UITableViewStyleGrouped];
        HTView_origin.view.frame = CGRectMake(0, 0, 320, 440);
        [setStartStationController.view addSubview:HTView_origin.view];
        [setStartStationController.view addSubview:bg];
        setStartStationController.tabBarItem.tag=0;
        HTView_origin.delegate = self;
        setStartStationController.tabBarItem.image = [UIImage imageNamed:@"bank.png"];
        ///////////////////////////////////////////////////////////
        HTView_terminal = [[setHTOriginAndTerminalViewController alloc] initWithStyle:UITableViewStyleGrouped];
        HTView_terminal.view.frame = CGRectMake(0, 0, 320, 440);
        [setdepatureStationviewController.view addSubview:HTView_terminal.view];
        [setdepatureStationviewController.view addSubview:bg];
        HTView_terminal.delegate = self;
        setdepatureStationviewController.tabBarItem.tag=1;
        setdepatureStationviewController.tabBarItem.image = [UIImage imageNamed:@"bank.png"];
        ///////////////////////////////////////////////////////////
    }
    
    timeChoose_moth = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(2.5, 5, 160, 320)];
    timeChoose_day = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(157.5, 5, 160, 320)];
    [setTimeviewController.view addSubview:timeChoose_moth];
    [setTimeviewController.view addSubview:timeChoose_day];
    [setTimeviewController.view addSubview:bg];
    timeChoose_moth.delegate = self;
    timeChoose_moth.dataSource = self;
    [timeChoose_moth reloadData];
    timeChoose_day.delegate = self;
    timeChoose_day.dataSource = self;
    [timeChoose_day reloadData];
    setTimeviewController.tabBarItem.image = [UIImage imageNamed:@"TimeDrive.png"];
    //////////////////////////////////////////////////////////
    
    view4 = [[TrainStyleViewController alloc] initWithStyle:UITableViewStyleGrouped];
    view4.title = type4;
    view4.view.frame = CGRectMake(0, 10, 320, 420);
    [setTrainTypeviewController.view addSubview:view4.tableView];
    view4.delegate = self;
    setTrainTypeviewController.tabBarItem.tag=3;
    setTrainTypeviewController.tabBarItem.image = [UIImage imageNamed:@"train.png"];
    //////////////////////////////////////////////////////////
if (!isHighSpeedTrain){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/stationNumber.plist"];
    stationNum = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    view5 = [[StaionInfoTableViewController alloc] init];
    view5.dataSource = self;
    view5.title = type5;
    view5.view.frame = CGRectMake(0, 10, 320, 425);
    resultViewController.view.frame= CGRectMake(0, 10, 320, 425);
    [resultViewController.view addSubview:view5.tableView];
    resultViewController.tabBarItem.tag=4;
    resultViewController.tabBarItem.image = [UIImage imageNamed:@"magnify.png"];
    [view5 recieveData];
}
else {
    ht_searchResult = [[HTSearchResultViewController alloc]init];
    ht_searchResult.dataSource = self;
    ht_searchResult.view.frame = CGRectMake(0, 10, 320, 425);
    resultViewController.view.frame= CGRectMake(0, 10, 320, 425);
    [resultViewController.view addSubview:ht_searchResult.tableView];
    resultViewController.tabBarItem.tag=4;
    resultViewController.tabBarItem.image = [UIImage imageNamed:@"magnify.png"];
    downloadView = [DownloadingView new];
    [ht_searchResult recieveData];
}
    //////////////////////////////////////////////////////////
    if(!isHighSpeedTrain)
        viewControllers = [[NSArray alloc]initWithObjects:setStartStationController, setdepatureStationviewController,setTimeviewController,setTrainTypeviewController ,resultViewController,nil];
    else
        viewControllers = [[NSArray alloc]initWithObjects:setStartStationController, setdepatureStationviewController,setTimeviewController,resultViewController,nil];
    
    [viewControllers retain];
    [self setViewControllers:viewControllers animated:YES];
    self.delegate=self;
    

self.tabBar.frame = CGRectMake(0, 480-self.tabBar.frame.size.height-20, self.tabBar.frame.size.width, self.tabBar.frame.size.height+20);

[self addTabBarArrow];
[self navAddRightButton];
    [self viewDidLoad];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    }
    return self;
}

-(void)navAddRightButton{
    UIBarButtonItem * swapStation = [[UIBarButtonItem alloc]initWithTitle:@"往返切換" style:UIBarButtonItemStylePlain target:self action:@selector(SwapStation)];
    self.navigationItem.rightBarButtonItem = swapStation;
}
-(void)SwapStation{
    NSString * tmpForSwap = [[NSString alloc]initWithString:DepatureStation];
    DepatureStation = [NSString stringWithString:startStaion];
    startStaion = [NSString stringWithString:tmpForSwap];
    [self viewDidLoad];
    [view5 recieveData];
}

-(void)didSwipe:(id)sender{
 UISwipeGestureRecognizer *swipeRecognizer = (UISwipeGestureRecognizer *)sender;
    if(swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft ||swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight ){
        [self SwapStation];
    }
}
-(int)initialRow:(StationPickerPickerView *)pickerView{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"MM"];
    currentMonth =  [[formatter stringFromDate:date]intValue];
    [formatter setDateFormat:@"dd"];
    currentDay =  [[formatter stringFromDate:date]intValue];
    if (pickerView == timeChoose_moth){
        return currentMonth;
    }
    else if (pickerView == timeChoose_day){
        return currentDay;
    }
}
-(void) createData{
    moth = [[NSArray alloc ]initWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil ];
    day = [[NSMutableArray alloc]init];
    for (int _moth = 1 ; _moth<=12; ++_moth){
        NSMutableArray *tmp  = [[[NSMutableArray alloc]init]autorelease];
        if (_moth==1 || _moth==3 || _moth==5 || _moth==7 || _moth==8 || _moth==10 || _moth==12){
            for (int _day = 1; _day<=31 ; _day++)
                [tmp addObject:[NSString stringWithFormat:@"%d",_day]];
            [day addObject:tmp];
        }
        else if (_moth == 2){ tmp  = [[[NSMutableArray alloc]init]autorelease];
            for (int _day = 1; _day<=28 ; _day++)
                [tmp addObject:[NSString stringWithFormat:@"%d",_day]];
            [day addObject:tmp];
        }
       else {
           tmp  = [[[NSMutableArray alloc]init]autorelease];
           for (int _day = 1; _day<=30 ; _day++)
               [tmp addObject:[NSString stringWithFormat:@"%d",_day]];
           [day addObject:tmp];
       }
    }
}


- (NSString *)pickerView:(StationPickerPickerView *)pickerView titleForRow:(NSInteger)row
{
     if (pickerView == timeChoose_moth) return [moth objectAtIndex:row];
    else if (pickerView == timeChoose_day)
        return [[day objectAtIndex:dateSelected]objectAtIndex:row] ;
}

- (NSInteger)numberOfRowsInPickerView:(StationPickerPickerView *)pickerView
{
  
    if (pickerView == timeChoose_moth) return [moth count];
     else if (pickerView == timeChoose_day)
         return [[day objectAtIndex:dateSelected]count] ;
}

- (void)pickerView:(StationPickerPickerView *)pickerView didSelectRow:(NSInteger)row
{
    
     if (pickerView == timeChoose_moth){
        dateSelected = row;
        [timeChoose_day reloadData];
    }
    /* else if (pickerView == _view1 || pickerView == _view2)
         NSLog(@"%@",[[station objectAtIndex:NowStationRow]objectAtIndex:row]);*/
    
}
- (NSString *) pickerView : (StationPickerPickerView *) pickerView nowSelected:(NSInteger) row{
     if (pickerView == timeChoose_moth) return [moth objectAtIndex:row-1];
     else if (pickerView == timeChoose_day)
         return [[day objectAtIndex:dateSelected]objectAtIndex:row-1] ;
}


- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.tabBar.frame.size.width / [viewControllers count];
    NSLog(@"%f / %u",self.tabBar.frame.size.width , self.tabBar.items.count);
    CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
    return (tabIndex * tabItemWidth) + halfTabItemWidth;
}
- (void) addTabBarArrow
{
    UIImage* tabBarArrowImage = [UIImage imageNamed:@"TabBarNipple@2x.png"];
    self.tabBarArrow = [[[UIImageView alloc] initWithImage:tabBarArrowImage] autorelease];
    CGFloat verticalLocation = 340;
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
    NSLog(@"%d", viewController.tabBarItem.tag);
        if (viewController.tabBarItem.tag==4){
           // dispatch_sync( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //[downloadView AlertViewStart];
            //});
            dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [view5 recieveData];
                [ht_searchResult recieveData];
                dispatch_suspend(dispatch_get_current_queue());
            });
            
           // [downloadView AlertViewEnd];
        }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if(!_isHightSpeedTrain)
       self.title = [NSString stringWithFormat: @" 基隆 → 臺北"];
    else self.title = [NSString stringWithFormat: @" 台北 → 左營"];
   
    if (((startStaion && DepatureStation) &&![startStaion isEqualToString:@""] ))
     self.title = [NSString stringWithFormat: @" %@ → %@",startStaion,DepatureStation];
    
    
    UISwipeGestureRecognizer *swipeRecognizer_right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    [swipeRecognizer_right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRecognizer_right];
    UISwipeGestureRecognizer *swipeRecognizer_left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    [swipeRecognizer_left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeRecognizer_left];
  //  [swipeRecognizer release];
    
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)SetOriginAndStationViewTableView:(UITableViewController *)tableView nowSelected:(NSString *)station{
    if (tableView==view1)
        startStaion = [[NSString stringWithFormat:@"%@", station ] retain];
    else if (tableView==view2)
        DepatureStation = [[NSString stringWithFormat:@"%@", station ]retain];
    [self viewDidLoad];
}

-(void)setHTOriginAndTerminalTableView:(UITableViewController*) tableView nowSelected:(NSString*) station{
    if (tableView==HTView_origin)
        startStaion = [[NSString stringWithFormat:@"%@", station ] retain];
    else if (tableView==HTView_terminal)
        DepatureStation = [[NSString stringWithFormat:@"%@", station ]retain];
    [self viewDidLoad];

}
/*-(void)CreateStationNumPlist{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"stationNum"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray * tmp_token = [content componentsSeparatedByString:@"\n"];
    NSMutableArray * token = [NSMutableArray new];
    int _switch=1;
    NSMutableDictionary * stationNumberDic = [NSMutableDictionary new];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSFileManager * fileManager = nil;
    NSString *documentsDirectory = [paths objectAtIndex:0];
    for (NSString* objInTmp in tmp_token){
        if (_switch==1)
            [token addObject:objInTmp];
        _switch*=-1;
        
    }
    for (NSString * objInToken in token){
        if (![stationNumberDic objectForKey:[objInToken substringToIndex:4]])
           // NSLog(@"%@",[objInToken substringWithRange:NSMakeRange([objInToken length]-2, 1)] );
            if ([[objInToken substringWithRange:NSMakeRange([objInToken length]-2, 1)] isEqualToString: @" "])
                [stationNumberDic setObject:[objInToken substringToIndex:4] forKey:[objInToken substringWithRange:NSMakeRange(4, [objInToken length]-6)]];
            else
            [stationNumberDic setObject:[objInToken substringToIndex:4] forKey:[objInToken substringWithRange:NSMakeRange(4, [objInToken length]-5)]];
    }
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"stationNumber.plist"];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"stationNumber" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
    }
    [stationNumberDic writeToFile:plistPath atomically: YES];
 NSArray *arr= [stationNumberDic allKeys];

}*/
- (NSURL*)StationInfoURL:(StaionInfoTableViewController *)stationInfoTableView{
   //[self CreateStationNumPlist];
    stationInfoTableView_delegate = self;

    if(isinitData) {
        isinitData = false;
        return [NSURL URLWithString:@""];
    }
   if (![startStaion isEqualToString:@""] && ![DepatureStation isEqualToString:@""] ){
        
        NSString *StartStationID = [NSString stringWithFormat:@"%@",[stationNum valueForKey:startStaion]];
        NSString *DepatureStationID= [NSString stringWithFormat:@"%@",[stationNum valueForKey:DepatureStation]];
        // NSArray *arr= [stationNum allKeys];
        NSString * queryURL = [[NSString alloc]initWithString:@"http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=0&searchdate=2012%2F"];
       queryURL=[queryURL stringByAppendingString:[NSString stringWithFormat:@"%d",currentMonth]];
       queryURL= [queryURL stringByAppendingString:@"%2F"];
       queryURL= [queryURL stringByAppendingString:[NSString stringWithFormat:@"%d",currentDay]];
       queryURL= [queryURL stringByAppendingString:[NSString stringWithFormat:@"&fromstation=%@&tostation=%@&",StartStationID,DepatureStationID]];
       queryURL= [queryURL stringByAppendingString:[NSString stringWithFormat:@"trainclass=%@&fromtime=0000&totime=2359",trainStyle]];
     //  NSLog( @"%@",queryURL);
      
     return [NSURL URLWithString:queryURL];
   }
    
  
}


-(void)TrainStyle:(TrainStyleViewController *)tableView nowSelectedRow:(NSInteger)indexPath{
    
    switch(indexPath){
        case 0 :
            trainStyle = @"'1100'%2c'1101'%2c'1102'%2c'1110'%2c'1120'"; break;
        case 1 : trainStyle = @"'1131'%2c'1132'%2c'1140'"; break;
        case 2 : trainStyle = @"2"; break;
    
    }
}

- (NSString *)startStationTitile:(StaionInfoTableViewController *)stationInfoTableView{
    if (![startStaion isEqualToString:@""] && startStaion)
    return startStaion;
    else return @"基隆";
}
- (NSString *)depatureStationTitile:(StaionInfoTableViewController *)stationInfoTableView{
     if (![DepatureStation isEqualToString:@""] && DepatureStation)
         return DepatureStation;
    else return @"臺北";
}


- (NSURL*)HTStationInfoURL:(HTSearchResultViewController *)stationInfoTableView{
    NSString * URL = [NSString stringWithFormat:@"http://www.thsrc.com.tw/tc/ticket/tic_time_pop_summary.asp?sdate=2012/%d/%d",currentMonth,currentDay];
   NSURL * queryURL = [[NSURL alloc]initWithString:URL];
   return queryURL;
}
- (NSString *)HTstartStationTitile:(HTSearchResultViewController *)stationInfoTableView{
    if (![startStaion isEqualToString:@""] && startStaion)
        return startStaion;
    else return @"台北";
}
- (NSString *)HTdepatureStationTitile:(HTSearchResultViewController *)stationInfoTableView{
    if (![DepatureStation isEqualToString:@""] && DepatureStation)
        return DepatureStation;
    else return @"左營";
}
@end