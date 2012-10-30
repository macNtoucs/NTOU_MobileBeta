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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent: event];
}

-(IBAction)cancel:(id)sender{
    [self.view removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_topView addSubview:_cancelButton];
    [_topView addSubview:_addButton];
    [_bottomView addSubview:_classNameField];
    [_bottomView addSubview:_teacherNameField];
    [_bottomView addSubview:_roomNameField];
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
    [_classNameField release];
    [_teacherNameField release];
    [_roomNameField release];
    [_cancelButton release];
    [_addButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopView:nil];
    [self setBottomView:nil];
    [self setClassNameField:nil];
    [self setTeacherNameField:nil];
    [self setRoomNameField:nil];
    [self setCancelButton:nil];
    [self setAddButton:nil];
    [super viewDidUnload];
}
@end
