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
@synthesize delegate;
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

/*-(IBAction)keyboardShowAndDismiss:(id)sender
{
    static BOOL set = NO;
    if (bool) {
        <#statements-if-true#>
    } else {
        <#statements-if-false#>
    }
}*/

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _bottomView.frame = CGRectMake(_bottomView.frame.origin.x,
                                                        _bottomView.frame.origin.y - 210,
                                                        _bottomView.frame.size.width,
                                                        _bottomView.frame.size.height);
                     }
                     completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _bottomView.frame = CGRectMake(_bottomView.frame.origin.x,
                                                        _bottomView.frame.origin.y + 210,
                                                        _bottomView.frame.size.width,
                                                        _bottomView.frame.size.height);
                     }
                     completion:nil];
    
}

-(IBAction)cancel:(id)sender{
    CGRect basketTopFrame = CGRectMake(_topView.frame.origin.x, -_topView.frame.origin.y, _topView.frame.size.width, _topView.frame.size.height);
    CGRect basketBottomFrame = CGRectMake(_bottomView.frame.origin.x, self.view.bounds.size.height+22, _bottomView.frame.size.width, _bottomView.frame.size.height);
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _topView.frame = basketTopFrame;
                         _bottomView.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                     }];
    [delegate changeTapEnable];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad
{
    
    CGRect basketTopFrame = _topView.frame;
    _topView.frame = CGRectMake(basketTopFrame.origin.x, -28, basketTopFrame.size.width, basketTopFrame.size.height);
    CGRect basketBottomFrame = _bottomView.frame;
    _bottomView.frame = CGRectMake(basketBottomFrame.origin.x, self.view.bounds.size.height+22, basketBottomFrame.size.width, basketTopFrame.size.height);
    [super viewDidLoad];
    [_topView addSubview:_cancelButton];
    [_topView addSubview:_addButton];
    [_bottomView addSubview:_classNameField];
    [_bottomView addSubview:_teacherNameField];
    [_bottomView addSubview:_roomNameField];
    
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _topView.frame = basketTopFrame;
                         _bottomView.frame = basketBottomFrame;
                     } 
                     completion:^(BOOL finished){
                     }];
    [delegate changeTapEnable];
   /* [[NSNotificationCenter defaultCenter] addObserver:_classNameField
                                             selector:@selector(keyboardShowAndDismiss:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];*/
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
