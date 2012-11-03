//
//  StationInfoViewController.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/3.
//
//

#import "StationInfoViewController.h"

@interface StationInfoViewController ()

@end

@implementation StationInfoViewController
@synthesize stationInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        stationInfo = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   [ stationInfo loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=0&searchdate=2012%2F11%2F05&fromstation=1008&tostation=1001&trainclass=2&fromtime=0000&totime=2359"]]];
//[ stationInfo loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://163.29.3.96/mobile/clean/query.jsp"]]];

    [self.view addSubview:stationInfo];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
