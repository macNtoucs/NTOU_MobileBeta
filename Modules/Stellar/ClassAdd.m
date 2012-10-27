//
//  ClassAdd.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

#import "ClassAdd.h"

@interface ClassAdd ()

@end

@implementation ClassAdd

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_topView release];
    [_bottomView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopView:nil];
    [self setBottomView:nil];
    [super viewDidUnload];
}
@end
