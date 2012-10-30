//
//  ClassAdd.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

#import <UIKit/UIKit.h>

@interface ClassAdd : UIViewController
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UITextField *classNameField;
@property (retain, nonatomic) IBOutlet UITextField *teacherNameField;
@property (retain, nonatomic) IBOutlet UITextField *roomNameField;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;
@property (retain, nonatomic) IBOutlet UIButton *addButton;

-(IBAction)cancel:(id)sender;

@end
