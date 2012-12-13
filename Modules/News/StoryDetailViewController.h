#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ShareDetailViewController.h"
#import <MessageUI/MessageUI.h>

@class NewsStory;
@class StoryListViewController;

//@interface StoryDetailViewController : ShareDetailViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate, ShareItemDelegate>
@interface StoryDetailViewController : UIViewController <UIWebViewDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong) StoryListViewController *newsController;
@property (strong) NSArray *story;
@property (strong) UIWebView * webView;
@property (strong) NSString *type;      //temp
//@property (strong) UITableView *table;
@property (strong) UITextView *textView1;
@property (strong) UITextView *textView2;

- (void)displayStory:(NSArray *)aStory;
-(IBAction)openMail:(id)sender;

@end
