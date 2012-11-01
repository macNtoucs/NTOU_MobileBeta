//
//  ClassInfoViewController.m
//  MIT Mobile
//
//  Created by mac_hero on 12/11/1.
//
//

#import "ClassInfoViewController.h"

@interface ClassInfoViewController ()

@end

@implementation ClassInfoViewController
@synthesize tag;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ClassLabelBasis * classinfo = [[[ClassLabelBasis alloc] initWithFrame:CGRectMake(100, 0, 320, 40)] autorelease];
        classinfo.backgroundColor = [UIColor clearColor];
        classinfo.text = [NSString stringWithFormat:@"教授名稱：林清池\n教室地點：CS301"];
        classinfo.font = [UIFont fontWithName:@"AppleGothic" size:15];
        classinfo.lineBreakMode = UILineBreakModeWordWrap;
        classinfo.numberOfLines = 0;
        [self.view addSubview:classinfo];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
