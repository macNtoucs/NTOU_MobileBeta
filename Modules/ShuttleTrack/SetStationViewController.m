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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ThroughTap *bg = [[ThroughTap alloc]initWithFrame:CGRectMake(0,0,320,480)];
         startStaion_origin =0;
         depatureStation_origin=0;
         dateSelected=0;
        startStaion = [NSString new];
        DepatureStation = [NSString new];
        queryDate = [NSString new];
      //[self addSelectView];
        [self createData];
        UIViewController *setStartStationController,
                         *setdepatureStationviewController,
                         *setTimeviewController,
                         *setTrainTypeviewController,
                         *resultViewController;
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
       
        
        view1 = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(2.5, 5, 160, 320)];
        _view1 = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(157.5, 5, 160, 320)];
        [setStartStationController.view addSubview:view1];
        [setStartStationController.view addSubview:_view1];
        [setStartStationController.view addSubview:bg];
        view1.delegate = self;
        view1.dataSource = self;
        [view1 reloadData];
        _view1.delegate = self;
        _view1.dataSource = self;
        [_view1 reloadData];
        setStartStationController.tabBarItem.tag=0;
        ///////////////////////////////////////////////////////////
        view2 = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(2.5, 5, 160, 320)];
        _view2 = [[StationPickerPickerView alloc] initWithFrame:CGRectMake(157.5, 5, 160, 320)];
        [setdepatureStationviewController.view addSubview:view2];
        [setdepatureStationviewController.view addSubview:_view2];
        [setdepatureStationviewController.view addSubview:bg];
        view2.delegate = self;
        view2.dataSource = self;
        [view2 reloadData];
        _view2.delegate = self;
        _view2.dataSource = self;
        [_view2 reloadData];
        setdepatureStationviewController.tabBarItem.tag=1;
        ///////////////////////////////////////////////////////////
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
        setTimeviewController.tabBarItem.tag=2;
        //////////////////////////////////////////////////////////
        
        view4 = [[TrainStyleViewController alloc] initWithStyle:UITableViewStyleGrouped];
        view4.title = type4;
        view4.view.frame = CGRectMake(0, 10, 320, 420);
        [setTrainTypeviewController.view addSubview:view4.tableView];
        setTrainTypeviewController.tabBarItem.tag=3;
        //////////////////////////////////////////////////////////
         
        view5 = [[StaionInfoTableViewController alloc] init];
        view5.dataSource = self;
        view5.title = type5;
        view5.view.frame = CGRectMake(0, 10, 320, 420);
        [resultViewController.view addSubview:view5.tableView];
        resultViewController.tabBarItem.tag=4;
        [view5 recieveData];
         //////////////////////////////////////////////////////////
        viewControllers = [[NSArray alloc]initWithObjects:setStartStationController, setdepatureStationviewController,setTimeviewController,setTrainTypeviewController ,resultViewController,nil];
        
       
      [self setViewControllers:viewControllers animated:YES];
        self.delegate=self;
       
        view2.delegate = self;
       
        view2.dataSource = self;
        view1.rowFont = [UIFont boldSystemFontOfSize:19.0];
        view1.rowIndent = 10.0;
        [self addTabBarArrow];
    }
    self.tabBar.frame = CGRectMake(0, 480-self.tabBar.frame.size.height-20, self.tabBar.frame.size.width, self.tabBar.frame.size.height+20);
   
    return self;
}

-(void) createData{
    region = [[NSArray alloc] initWithObjects:@"台北", @"桃園",@"新竹",@"苗栗",@"台中",@"彰化",@"雲林",@"南投",@"嘉義",@"台南",@"高雄",@"屏東",@"台東",@"花蓮",@"宜蘭",nil];
    station = [[NSArray alloc]initWithObjects:
                [NSArray arrayWithObjects:@"福隆",@"貢寮",@"雙溪",@"牡丹",@"三貂嶺",@"侯硐",@"瑞芳",@"四腳亭",@"暖暖",@"基隆",@"三坑",@"八堵",@"七堵",@"百福",@"五堵",@"汐止",@"汐科",@"南港",@"松山",@"台北",@"萬華",@"板橋",@"浮州",@"樹林",@"山佳",@"鶯歌",nil ],
               [NSArray arrayWithObjects:@"桃園",@"內壢",@"中壢",@"埔心",@"楊梅",@"富岡",nil ],
               [NSArray arrayWithObjects:@"北湖",@"湖口",@"新豐",@"竹北",@"北新竹",@"新竹",@"香山",nil ],
               [NSArray arrayWithObjects:@"崎頂",@"竹南",@"談文",@"大山",@"後龍",@"龍港",@"白沙屯",@"新埔",@"通霄",@"苑里",@"豐富",@"苗栗",@"南勢",@"銅鑼",@"三義",nil ],
                [NSArray arrayWithObjects:@"日南",@"大甲",@"台中港",@"清水",@"沙鹿",@"龍井",@"大肚",@"追分",@"泰安",@"后里",@"豐原",@"潭子",@"太原",@"台中",@"大慶",@"烏日",@"新烏日",@"成功",nil ],
               [NSArray arrayWithObjects:@"彰化",@"花壇",@"大村",@"員林",@"永靖",@"社頭",@"田中",@"二水",nil ],
               [NSArray arrayWithObjects:@"林內",@"石榴",@"斗六",@"斗南",@"石龜",nil ],
               [NSArray arrayWithObjects:@"源泉",@"濁水",@"龍泉",@"集集",@"水里",@"車程",nil ],
               [NSArray arrayWithObjects:@"大林",@"民雄",@"嘉北",@"嘉義",@"水上",@"南靖",nil ],
               [NSArray arrayWithObjects:@"後壁",@"新營",@"柳營",@"林鳳營",@"隆田",@"拔林",@"善化",@"南科",@"新市",@"永康",@"大橋",@"台南",@"保安",@"中洲",@"長榮大學",@"沙崙",nil ],
               [NSArray arrayWithObjects:@"大湖",@"路竹",@"岡山",@"橋頭",@"楠梓",@"新左營",@"左營",@"高雄",@"鳳山",@"後庄",@"九曲堂",nil ],
               [NSArray arrayWithObjects:@"六塊厝",@"屏東",@"歸來",@"麟落",@"西勢",@"竹田",@"潮州",@"崁頂",@"南州",@"鎮安",@"林邊",@"佳冬",@"東海",@"枋寮",@"加祿",@"內獅",@"枋山",nil ],
               [NSArray arrayWithObjects:@"古莊",@"瀧溪",@"大武",@"金崙",@"太麻里",@"知本",@"康樂",@"台東",@"山里",@"鹿野",@"瑞源",@"瑞和",@"月美",@"關山",@"海瑞",@"池上",nil ],
               [NSArray arrayWithObjects:@"富里",@"東竹",@"東里",@"玉里",@"三民",@"瑞穗",@"富源",@"大富",@"光榮",@"萬榮",@"鳳林",@"南平",@"溪口",@"豐田",@"壽豐",@"平和",@"志學",@"吉安",@"花蓮",@"北埔",@"景美",@"新城",@"崇德",@"和仁",@"和平",nil ],
               [NSArray arrayWithObjects:@"漢本",@"武塔",@"南澳",@"東澳",@"永樂",@"蘇澳",@"蘇澳新",@"新馬",@"冬山",@"羅東",@"中里",@"二結",@"宜蘭",@"四城",@"礁溪",@"頂埔",@"頭城",@"外澳",@"龜山",@"大溪",@"大里",@"石城",nil ]
               
               , nil];
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

-(void) addSelectView{
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(160,140, 160, 60)];
    //sampleView.backgroundColor = [UIColor whiteColor];
    whiteView.backgroundColor = [UIColor grayColor];
    whiteView.alpha=0.1;
    whiteView.layer.cornerRadius = 2.5; // 圓角的弧度
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.shadowColor = [[UIColor blackColor] CGColor];
    whiteView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    whiteView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    whiteView.layer.shadowRadius = 10.0f; // 陰影發散的程度
    whiteView.layer.borderWidth = 1;
    whiteView.layer.borderColor = [[UIColor blackColor] CGColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = whiteView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor grayColor] CGColor], nil]; // 由上到下的漸層顏色
    [whiteView.layer insertSublayer:gradient atIndex:0];
    blueView = [[UIView alloc] initWithFrame:CGRectMake(8,140, 150, 60)];
    blueView.backgroundColor = [UIColor colorWithRed:135/255 green:206/255 blue:235.0/255.0 alpha:0.05];
    blueView.layer.cornerRadius = 2.5; // 圓角的弧度
    blueView.layer.masksToBounds = YES;
    blueView.layer.shadowColor = [[UIColor blackColor] CGColor];
    blueView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    blueView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    blueView.layer.shadowRadius = 10.0f; // 陰影發散的程度
    blueView.layer.borderWidth = 1;
    blueView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:whiteView];
    [self.view addSubview:blueView];
  
    
}
- (NSString *)pickerView:(StationPickerPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == view1 || pickerView == view2)
        return [region objectAtIndex:row];
    else if (pickerView == _view1 )
        return [[station objectAtIndex:startStaion_origin]objectAtIndex:row];
    else if (pickerView == _view2 )
        return [[station objectAtIndex:depatureStation_origin]objectAtIndex:row];
    else if (pickerView == timeChoose_moth) return [moth objectAtIndex:row];
    else if (pickerView == timeChoose_day)
        return [[day objectAtIndex:dateSelected]objectAtIndex:row] ;
}

- (NSInteger)numberOfRowsInPickerView:(StationPickerPickerView *)pickerView
{
   if (pickerView == view1 || pickerView == view2)
        return [region count];
     else if (pickerView == _view1 )
        return [[station objectAtIndex:startStaion_origin]count];
     else if (pickerView == _view2 )
         return [[station objectAtIndex:depatureStation_origin]count];
     else if (pickerView == timeChoose_moth) return [moth count];
     else if (pickerView == timeChoose_day)
         return [[day objectAtIndex:dateSelected]count] ;
}

- (void)pickerView:(StationPickerPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView == view1 || pickerView == view2){
        NSLog(@"%@",[region objectAtIndex:row]);
        if (pickerView ==view1) {
            startStaion_origin = row;
            [_view1 reloadData];
          }
        else  {
            depatureStation_origin = row;
            [_view2 reloadData];
        }
    }
    else if (pickerView == _view1){
    startStaion = [[station objectAtIndex:startStaion_origin]objectAtIndex:row];
          [self viewDidLoad];
    }
    else if (pickerView == _view2){
     DepatureStation = [[station objectAtIndex:depatureStation_origin]objectAtIndex:row];
          [self viewDidLoad];
    }
    
    else if (pickerView == timeChoose_moth){
        dateSelected = row;
        [timeChoose_day reloadData];
    }
    /* else if (pickerView == _view1 || pickerView == _view2)
         NSLog(@"%@",[[station objectAtIndex:NowStationRow]objectAtIndex:row]);*/
    
}
- (NSString *) pickerView : (StationPickerPickerView *) pickerView nowSelected:(NSInteger) row{
   if (pickerView == view1 || pickerView == view2)
        return [region objectAtIndex:row];
     else if (pickerView == _view1 )
        return [[station objectAtIndex:startStaion_origin]objectAtIndex:row];
     else if (pickerView == _view2 )
         return [[station objectAtIndex:depatureStation_origin]objectAtIndex:row];
     else if (pickerView == timeChoose_moth) return [moth objectAtIndex:row];
     else if (pickerView == timeChoose_day)
         return [[day objectAtIndex:dateSelected]objectAtIndex:row] ;
}


- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.tabBar.frame.size.width / self.tabBar.items.count;
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
    if (viewController.tabBarItem.tag==3 || viewController.tabBarItem.tag==4){
        whiteView.hidden=YES;
        blueView.hidden=YES;
        [self viewDidLoad];
    }
    else {
        whiteView.hidden=NO;
        blueView.hidden=NO;
    }
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if (startStaion && DepatureStation)
     self.title = [NSString stringWithFormat: @"%@ -> %@",startStaion,DepatureStation];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL*)StationInfoURL:(StaionInfoTableViewController *)stationInfoTableView{
   
        return [NSURL URLWithString:@"http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=0&searchdate=2012%2F11%2F15&fromstation=1008&tostation=1001&trainclass=2&fromtime=0000&totime=2359"];
   
}
@end