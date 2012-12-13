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
@synthesize textView1;
@synthesize textView2;

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
        /*table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
         table.dataSource = self;
         table.delegate = self;
         [self.view addSubview:table];*/
        
        /*CGRect textViewFrame = CGRectMake(20.0f, 20.0f, 280.0f, 124.0f);
         textView1 = [[UITextView alloc] initWithFrame:textViewFrame];
         textView1.returnKeyType = UIReturnKeyDone;
         textView1.delegate = self;
         [textView1 setEditable:NO];
         
         //[[textView1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
         //[[textView1 layer] setBorderWidth:1.5];
         [[textView1 layer] setCornerRadius:15];
         //[textView1 setBackgroundColor:[UIColor clearColor]];
         [textView1 setClipsToBounds:YES];*/
        
        CGRect textViewFrame = CGRectMake(20.0f, 20.0f, 280.0f, 124.0f);
        textView1 = [[UITextView alloc] initWithFrame:textViewFrame];
        
        NSString * tmpDate = @"公告日期：";
        NSString * date = [[tmpDate stringByAppendingString:[story objectAtIndex:0]] stringByAppendingString:@"\n"];
        NSString * tmpUndertaker = @"承辦人員：";
        NSString * undertaker = [[tmpUndertaker stringByAppendingString:[story objectAtIndex:1]] stringByAppendingString:@"\n"];
        NSString * tmpContact = @"聯絡方式：";
        NSString * contact = [[tmpContact stringByAppendingString:[story objectAtIndex:2]] stringByAppendingString:@"\n"];
        NSString * tmpMain = @"主        旨：";
        NSString * main = [[tmpMain stringByAppendingString:[story objectAtIndex:3]] stringByAppendingString:@"\n"];
        
        textView1.text = [[[date stringByAppendingString:undertaker] stringByAppendingString:contact] stringByAppendingString:main];
        
        CGRect frame1 = textView1.frame;
        CGSize size1 = [textView1.text sizeWithFont:textView1.font
                        
                                  constrainedToSize:CGSizeMake(280, 1000)
                        
                                      lineBreakMode:UILineBreakModeTailTruncation];
        frame1.size.height = size1.height > 1 ? size1.height + 30 : 64;
        textView1.frame = frame1;
        
        textView1.returnKeyType = UIReturnKeyDone;
        textView1.delegate = self;
        [textView1 setEditable:NO];
        [[textView1 layer] setCornerRadius:15];
        [textView1 setClipsToBounds:YES];
        
        /*UIButton * undertakerButton = [UIButton buttonWithType:UIButtonTypeCustom];
         undertakerButton.frame = CGRectMake(0, 18, 150, 20);
         [undertakerButton setTitle:@"     ____" forState:UIControlStateNormal];
         [undertakerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         undertakerButton.backgroundColor = [UIColor clearColor];
         [undertakerButton addTarget:self action:@selector(openMail:) forControlEvents:UIControlEventTouchDown];
         [textView1 addSubview:undertakerButton];*/
        
        CGRect textViewFrameContent = CGRectMake(20.0f, 170.0f, 280.0f, 220.0f);
        textView2 = [[UITextView alloc] initWithFrame:textViewFrameContent];
        
        //[[textView2 layer] setBorderColor:[[UIColor blackColor] CGColor]];
        //[[textView2 layer] setBorderWidth:1.5];
        //[textView1 scrollRangeToVisible:[textView1 selectedRange]];
        //[textView2 scrollRangeToVisible:[textView2 selectedRange]];
        
        NSString * tmpContent = @"公告內容：";
        NSString * content = [[tmpContent stringByAppendingString:[story objectAtIndex:4]] stringByAppendingString:@"\n"];
        NSString * tmpAttachment = @"附        件：";
        NSString * attachment = [[tmpAttachment stringByAppendingString:[story objectAtIndex:5]] stringByAppendingString:@"\n"];
        
        textView2.text = [content stringByAppendingString:attachment];
        CGRect frame2 = textView2.frame;
        CGSize size2 = [textView2.text sizeWithFont:textView2.font
                        
                                  constrainedToSize:CGSizeMake(280, 200)
                        
                                      lineBreakMode:UILineBreakModeTailTruncation];
        frame2.size.height = size2.height > 1 ? size2.height + 30 : 64;
        textView2.frame = frame2;
        
        textView2.returnKeyType = UIReturnKeyDone;
        textView2.delegate = self;
        [textView2 setEditable:NO];
        [[textView2 layer] setCornerRadius:15];
        [textView2 setClipsToBounds:YES];
        
        [self.view addSubview:textView1];
        [self.view addSubview:textView2];
    }
    
    /*NSURL*url=[NSURL URLWithString:@"http://www.google.com"];
     NSURLRequest*request=[NSURLRequest requestWithURL:url];
     [webView loadRequest:request];
     //[self.view addSubview:webView];
     CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
     UIWebView *mainView = [[[UIWebView alloc] initWithFrame:mainFrame] autorelease];
     mainView.autoresizingMask = (UIViewAutoresizingFlexibleHeight |
     UIViewAutoresizingFlexibleWidth);
     mainView.autoresizesSubviews = YES;
     mainView.backgroundColor = [UIColor yellowColor];*/
    
    
    //webView.delegate = self;
    /*NSURL *url = [NSURL URLWithString:@"http://www.ntou.edu.tw/"];
     //NSString *path = @"http://www.ntou.edu.tw/";
     //NSURL *url = [NSURL fileURLWithPath:path];
     NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
     //將檔案載入UIWebView中
     //[webView loadRequest:requestURL];
     [mainView addSubview:webView];*/
    //self.storyView = webView;
    //[mainView addSubview:webView];
    //[self setView:webView];
    
    /*[self.storyPager setEnabled:[self.newsController canSelectPreviousStory] forSegmentAtIndex:0];
     [self.storyPager setEnabled:[self.newsController canSelectNextStory] forSegmentAtIndex:1];
     
     NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath] isDirectory:YES];
     NSURL *fileURL = [NSURL URLWithString:@"news/news_story_template.html" relativeToURL:baseURL];
     
     NSError *error = nil;
     NSMutableString *htmlString = [NSMutableString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
     if (!htmlString) {
     return;
     }
     
     NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
     [dateFormatter setDateFormat:@"MMM dd, y"];
     NSString *postDate = [dateFormatter stringFromDate:story.postDate];
     
     NSString *thumbnailURL = story.inlineImage.smallImage.url;
     NSString *thumbnailWidth = [story.inlineImage.smallImage.width stringValue];
     NSString *thumbnailHeight = [story.inlineImage.smallImage.height stringValue];
     if (!thumbnailURL) {
     thumbnailURL = @"";
     }
     if (!thumbnailWidth) {
     thumbnailWidth = @"";
     }
     if (!thumbnailHeight) {
     thumbnailHeight = @"";
     }
     
     NSInteger galleryCount = [story.galleryImages count];
     if (story.inlineImage) {
     galleryCount++;
     }
     
     // if not connected, pretend there are no images
     NSString *galleryCountString = ([ConnectionDetector isConnected]) ? [[NSNumber numberWithInteger:galleryCount] stringValue] : @"0";
     
     NSArray *keys = [NSArray arrayWithObjects:
     @"__TITLE__", @"__AUTHOR__", @"__DATE__", @"__BOOKMARKED__",
     @"__THUMBNAIL_URL__", @"__THUMBNAIL_WIDTH__", @"__THUMBNAIL_HEIGHT__",
     @"__GALLERY_COUNT__", @"__DEK__", @"__BODY__", nil];
     
     NSString *isBookmarked = ([self.story.bookmarked boolValue]) ? @"on" : @"";
     
     NSArray *values = [NSArray arrayWithObjects:
     story.title, story.author, postDate, isBookmarked,
     thumbnailURL, thumbnailWidth, thumbnailHeight,
     galleryCountString, story.summary, story.body, nil];
     
     [htmlString replaceOccurrencesOfStrings:keys withStrings:values options:NSLiteralSearch];
     
     // mark story as read
     self.story.read = [NSNumber numberWithBool:YES];
     [CoreDataManager saveDataWithTemporaryMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
     [self.storyView loadHTMLString:htmlString baseURL:baseURL];*/
}

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

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 return 2;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return 1;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
 }
 
 cell.textLabel.text = @"text1\ntext2";
 cell.detailTextLabel.text = @"detailText1\ndetailText2";
 
 return cell;
 }*/

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
