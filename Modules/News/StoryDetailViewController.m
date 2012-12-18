#import <QuartzCore/QuartzCore.h>

#import "StoryDetailViewController.h"

#import "MITConstants.h"
#import "ConnectionDetector.h"
#import "CoreDataManager.h"
#import "Foundation+MITAdditions.h"
#import "MFMailComposeViewController+RFC2368.h"
#import "MIT_MobileAppDelegate.h"
#import "MITMobileServerConfiguration.h"
#import "NewsStory.h"
#import "StoryListViewController.h"
#import "StoryGalleryViewController.h"
#import "URLShortener.h"

@interface StoryDetailViewController ()
@property (strong) UISegmentedControl *storyPager;
@property (strong) UIWebView *storyView;
@end

@implementation StoryDetailViewController
{
	StoryListViewController *newsController;
    NSArray *story;
}

@synthesize newsController;
@synthesize story;
@synthesize storyView = _storyView;
@synthesize storyPager = _storyPager;
@synthesize webView = _webView;
@synthesize type;
//@synthesize table;
@synthesize textView;
@synthesize textSubView;
@synthesize dataTableView;

- (void)dealloc
{
    self.newsController = nil;
    self.storyView = nil;
    self.story = nil;
    self.storyPager = nil;
    
    [super dealloc];
}

/*- (void)loadView {
 
 NSLog(@"StoryDetail.m loadView");
 
 CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
 UIWebView *mainView = [[[UIWebView alloc] initWithFrame:mainFrame] autorelease];
 mainView.autoresizingMask = (UIViewAutoresizingFlexibleHeight |
 UIViewAutoresizingFlexibleWidth);
 mainView.autoresizesSubviews = YES;
 mainView.backgroundColor = [UIColor yellowColor];
 
 {
 NSArray *pagerItems = [NSArray arrayWithObjects:
 [UIImage imageNamed:MITImageNameUpArrow],
 [UIImage imageNamed:MITImageNameDownArrow],
 nil];
 UISegmentedControl *pager = [[[UISegmentedControl alloc] initWithItems:pagerItems] autorelease];
 
 pager.momentary = YES;
 pager.segmentedControlStyle = UISegmentedControlStyleBar;
 pager.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
 UIViewAutoresizingFlexibleHeight |
 UIViewAutoresizingFlexibleBottomMargin);
 pager.frame = CGRectMake(0, 0, 80.0, CGRectGetHeight(pager.frame));
 
 [pager setEnabled:NO forSegmentAtIndex:0];
 [pager setEnabled:NO forSegmentAtIndex:1];
 
 [pager addTarget:self
 action:@selector(didPressNavButton:)
 forControlEvents:UIControlEventValueChanged];
 
 UIBarButtonItem *segmentItem = [[[UIBarButtonItem alloc] initWithCustomView:pager] autorelease];
 self.navigationItem.rightBarButtonItem = segmentItem;
 self.storyPager = pager;
 }
 {
 webView = [[[UIWebView alloc] initWithFrame:mainView.bounds] autorelease];
 webView.dataDetectorTypes = UIDataDetectorTypeLink;
 webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
 UIViewAutoresizingFlexibleHeight);
 webView.scalesPageToFit = NO;
 webView.delegate = self;
 [mainView addSubview:webView];
 self.storyView = webView;
 }
 
 
 }*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.shareDelegate = self;
	
    
    if (self.story) {
        
        NSLog(@"StoryDetail.m if");
		[self displayStory:self.story];
	}
}

- (void)displayStory:(NSArray *)aStory {
    
    
    NSLog(@"StoryDetail.m displayStory");
    
    if([self.type isEqual:@"CampusFocus"])
    {
        NSLog(@"StoryDetail.m if story = %@", story);
        
        self.webView.delegate = self;
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        
        NSString *query = [NSString stringWithFormat:@"%@", [story objectAtIndex:0]];
        
        NSString *strUrl = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:requestObj];
        
        [self.webView setScalesPageToFit:YES];
        [self.view addSubview:self.webView];
    }
    else
    {
        CGRect dataFrame = CGRectMake(0, 50, 320, 180);
        dataTableView = [[UITableView alloc] initWithFrame:dataFrame style:UITableViewStylePlain];
        dataTableView.dataSource = self;
        dataTableView.delegate = self;
        dataTableView.scrollEnabled = NO;
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        textView.editable = NO;
        textView.scrollEnabled = YES;
        
        
        
        NSString * tmpMain = @"主        旨：";
        NSString * main = [[tmpMain stringByAppendingString:[story objectAtIndex:3]] stringByAppendingString:@"\n"];
        
        //NSString * tmpContent = @"公告內容22223efghjkltyuoertyuifghjk\n\n\n\n\n\n\n\n\n\n\n\n：";
        //NSString * content = [[tmpContent stringByAppendingString:[story objectAtIndex:4]] stringByAppendingString:@"\n"];
        textSubView = [[UITextView alloc] initWithFrame:CGRectMake(0, 250, 320, 230)];
        textSubView.text = [story objectAtIndex:4];
        textSubView.editable = NO;
        
        [textView addSubview:textSubView];
        [textView addSubview:dataTableView];
        [self.view addSubview:textView];
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

/*- (CGRect) textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 100.0, 100.0);
}*/

-(IBAction)openMail:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"A Massage from MobileTuts+"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"firstMail@example.com", nil];
        [mailer setToRecipients:toRecipients];
        //UIImage *myImage = [UIImage imageNamed:<#(NSString *)#>];
        NSString *emailBody = @"Have you seen the MobileTuts+ web site?";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your deice"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed.:");
            break;
            
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 4;
}
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    NSString * tmpDate = @"公告日期：";
    NSString * tmpUndertaker = @"承辦人員：";
    NSString * tmpContact = @"聯絡方式：";
    NSString * tmpAttachment = @"附        件：";
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = tmpDate;
            cell.detailTextLabel.text = [story objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 1:
            cell.textLabel.text = tmpUndertaker;
            cell.detailTextLabel.text = [story objectAtIndex:1];
            break;
        case 2:
            cell.textLabel.text = tmpContact;
            cell.detailTextLabel.text = [story objectAtIndex:2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 3:
            cell.textLabel.text = tmpAttachment;
            cell.detailTextLabel.text = [story objectAtIndex:5];
            break;
    }
    return cell;
}

- (void)didPressNavButton:(id)sender {
    
    NSLog(@"StoryDetail.m didPressNavButton");
    
    /*if ([sender isKindOfClass:[UISegmentedControl class]]) {
     UISegmentedControl *theControl = (UISegmentedControl *)sender;
     NSInteger i = theControl.selectedSegmentIndex;
     NewsStory *newStory = nil;
     if (i == 0) { // previous
     newStory = [self.newsController selectPreviousStory];
     } else { // next
     newStory = [self.newsController selectNextStory];
     }
     if (newStory) {
     self.story = newStory;
     [self displayStory:self.story]; // updates enabled state of storyPager as a side effect
     }
     }*/
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"StoryDetail.m shouldStartLoadWithRequest");
    
    BOOL result = YES;
    
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        NSLog(@"StoryDetail.m navigationType");
        
		/*NSURL *url = [request URL];
         NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
         
         if ([[url scheme] caseInsensitiveCompare:@"mailto"] == NSOrderedSame) {
         if ([MFMailComposeViewController canSendMail]) {
         MFMailComposeViewController *mailController = [[[MFMailComposeViewController alloc] initWithURL:url] autorelease];
         mailController.mailComposeDelegate = self;
         [self presentModalViewController:mailController animated:YES];
         }
         } else if ([[url path] rangeOfString:[baseURL path] options:NSAnchoredSearch].location == NSNotFound) {
         [[UIApplication sharedApplication] openURL:url];
         result = NO;
         } else {
         if ([[url path] rangeOfString:@"image" options:NSBackwardsSearch].location != NSNotFound) {
         StoryGalleryViewController *galleryVC = [[[StoryGalleryViewController alloc] init] autorelease];
         //galleryVC.images = story.allImages;
         [self.navigationController pushViewController:galleryVC animated:YES];
         result = NO;
         } else if ([[url path] rangeOfString:@"bookmark" options:NSBackwardsSearch].location != NSNotFound) {
         // toggle bookmarked state
         //self.story.bookmarked = [NSNumber numberWithBool:([self.story.bookmarked boolValue]) ? NO : YES];
         [CoreDataManager saveData];
         } else if ([[url path] rangeOfString:@"share" options:NSBackwardsSearch].location != NSNotFound) {
         [self share:nil];
         }
         }*/
	}
	return result;
}

- (NSString *)actionSheetTitle {
	return @"Share article with a friend";
}

- (NSString *)emailSubject {
	//return [NSString stringWithFormat:@"MIT News: %@", story.title];
    return @"emailSubject";
}

- (NSString *)emailBody {
	//return [NSString stringWithFormat:@"I thought you might be interested in this story found on the MIT News Office:\n\n\"%@\"\n%@\n\n%@\n\nTo view this story, click the link above or paste it into your browser.", story.title, story.summary, story.link];
    return @"emailBody";
}

- (NSString *)fbDialogPrompt {
	return nil;
}

- (NSString *)fbDialogAttachment {
	/*return [NSString stringWithFormat:
     @"{\"name\":\"%@\","
     "\"href\":\"%@\","
     //"\"caption\":\"%@\","
     "\"description\":\"%@\","
     "\"media\":["
     "{\"type\":\"image\","
     "\"src\":\"%@\","
     "\"href\":\"%@\"}]"
     //,"\"properties\":{\"another link\":{\"text\":\"Facebook home page\",\"href\":\"http://www.facebook.com\"}}"
     "}",
     story.title, story.link, story.summary, story.inlineImage.smallImage.url, story.link];*/
    return @"fbDialogAttachment";
}

- (NSString *)twitterUrl {
	//return [NSString stringWithFormat:@"http://%@/n/%@", MITMobileWebGetCurrentServerDomain(), [URLShortener compressedIdFromNumber:story.story_id]];
    return @"twitterUrl";
}

- (NSString *)twitterTitle {
	//return story.title;
    return @"twitterTitle";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*#pragma mark MFMailComposeViewControllerDelegate
 - (void)mailComposeController:(MFMailComposeViewController*)controller
 didFinishWithResult:(MFMailComposeResult)result
 error:(NSError*)error
 {
 [self dismissModalViewControllerAnimated:YES];
 }*/
@end
