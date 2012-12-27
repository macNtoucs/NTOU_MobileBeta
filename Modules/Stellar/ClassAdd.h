//
//  ClassAdd.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//
@protocol ClassAdddelegate <NSObject>
@required
-(void) changeTapEnable;
-(void) NavigationBarShow;
-(void) buttonDidFinish:(int)FinishType StringData:(NSArray*)array;
@end

#import <UIKit/UIKit.h>
typedef enum {clean,modify,move}ButtonType;
@interface ClassAdd : UIViewController{
    id delegate;
}
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UITextField *classNameField;
@property (retain, nonatomic) IBOutlet UITextField *teacherNameField;
@property (retain, nonatomic) IBOutlet UITextField *roomNameField;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;
@property (retain, nonatomic) IBOutlet UIButton *addButton;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIButton *cleanInfo;
@property (retain, nonatomic) IBOutlet UIButton *modifyInfo;

-(IBAction)ConfirmOrCancel:(id)sender;
- (IBAction)clean:(UIButton *)sender;
- (IBAction)modify:(UIButton *)sender;
-(void)displayModifyButton:(BOOL)type;
-(void)buttonFuntion:(BOOL)type;
@property (nonatomic,assign) id delegate;


@end
