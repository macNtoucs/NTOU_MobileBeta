//
//  ClassAdd.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

#import "ClassAdd.h"
#import "ClassAddBackground.h"
#import "ClassDataBase.h"
@interface ClassAdd ()
{
    BOOL firstButtonType;
}

@end

@implementation ClassAdd
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        firstButtonType = NO;
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
                         ClassAddBackground*view = (ClassAddBackground *)self.view;
                         if ([view isKindOfClass:[ClassAddBackground class]]) {
                             view.statment = 1;
                         }
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
                         ClassAddBackground*view = (ClassAddBackground *)self.view;
                         if ([view isKindOfClass:[ClassAddBackground class]]) {
                             view.statment = 0;
                         }
                     }
                     completion:nil];
    
}

-(IBAction)ConfirmOrCancel:(id)sender{
    UIButton* button = (UIButton*)sender;
    CGRect basketTopFrame = CGRectMake(_topView.frame.origin.x, -_topView.frame.origin.y, _topView.frame.size.width, _topView.frame.size.height);
    CGRect basketBottomFrame = CGRectMake(_bottomView.frame.origin.x,[[UIScreen mainScreen] bounds].size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _topView.frame = basketTopFrame;
                         _bottomView.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                         [delegate NavigationBarShow];
                     }];
    [delegate changeTapEnable];
    if (button.tag) {
        [[ClassDataBase sharedData] ClassAddDecide];
    }
    else
        [[ClassDataBase sharedData] ClassAddCancel];
}

-(void)displayModifyButton:(BOOL)type
{
    if (type) {
        _modifyInfo.hidden = NO;
    }
    else
       _modifyInfo.hidden = YES;
}

-(void)buttonFuntion:(BOOL)type
{
    firstButtonType = type;
    if (type) {
        _cleanInfo.titleLabel.text = @"移動";
    }
    else
        _cleanInfo.titleLabel.text = @"清空";
}

-(void)resignResponder
{
    [_classNameField resignFirstResponder];
    [_teacherNameField resignFirstResponder];
    [_roomNameField resignFirstResponder];
}

- (IBAction)clean:(UIButton *)sender {
    if (firstButtonType) {  //移動
        _modifyInfo.hidden = YES;
        [delegate buttonDidFinish:move StringData:[NSArray arrayWithObjects:_classNameField.text,_teacherNameField.text,_roomNameField.text, nil]];
        [self buttonFuntion:NO];
    }
    else{   //清空
        _classNameField.text = [NSString string];
        _teacherNameField.text = [NSString string];
        _roomNameField.text = [NSString string];
        [delegate buttonDidFinish:clean StringData:[NSArray arrayWithObjects:_classNameField.text,_teacherNameField.text,_roomNameField.text, nil]];
    }
    [self resignResponder];
}

- (IBAction)modify:(UIButton *)sender { //修改
    [delegate buttonDidFinish:modify StringData:[NSArray arrayWithObjects:_classNameField.text,_teacherNameField.text,_roomNameField.text, nil]];
    _modifyInfo.hidden = YES;
    [self buttonFuntion:NO];
    [self resignResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad
{
    
    _topView.frame = CGRectMake(_topView.frame.origin.x, [[UIApplication sharedApplication] statusBarFrame].size.height, _topView.frame.size.width, _topView.frame.size.height);
    CGRect basketTopFrame = _topView.frame;
    _topView.frame = CGRectMake(basketTopFrame.origin.x, -28, basketTopFrame.size.width, basketTopFrame.size.height);
    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x,[[UIScreen mainScreen] bounds].size.height-_bottomView.frame.size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
    CGRect basketBottomFrame = _bottomView.frame;
    _bottomView.frame = CGRectMake(basketBottomFrame.origin.x,[[UIScreen mainScreen] bounds].size.height, basketBottomFrame.size.width, basketBottomFrame.size.height);
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
                         _bottomView.frame = CGRectMake(_bottomView.frame.origin.x,_bottomView.frame.origin.y-_bottomView.frame.size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
                     } 
                     completion:^(BOOL finished){
                         _topView.frame = basketTopFrame;
                     }];
    [delegate changeTapEnable];
    _modifyInfo.hidden = YES;
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
    [_titleLabel release];
    [_cleanInfo release];
    [_modifyInfo release];
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
    [self setTitleLabel:nil];
    [self setCleanInfo:nil];
    [self setModifyInfo:nil];
    [super viewDidUnload];
}
@end
