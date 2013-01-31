#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ShareDetailViewController.h"
#import <MessageUI/MessageUI.h>

@class NewsStory;
@class StoryListViewController;

//@interface StoryDetailViewController : ShareDetailViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate, ShareItemDelegate>
@interface StoryDetailViewController : UIViewController <UIWebViewDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>{
    UIButton * button;
}

@property (strong) StoryListViewController *newsController;
@property (strong) NSArray *story;
@property (strong) UIWebView * webView;
@property (strong) NSString *type;      //temp
//@property (strong) UITableView *table;
@property (strong) UITextView *textView;
@property (strong) UITextView * textSubView;
@property (strong) UITableView * dataTableView;
@property (nonatomic,retain) UIButton * button;
- (void)displayStory:(NSArray *)aStory;
-(IBAction)openMail:(id)sender;

@end
