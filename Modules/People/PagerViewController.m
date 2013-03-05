//
//  ViewController.m
//  PageViewController
//
//  Created by Tom Fewster on 11/01/2012.
//

#import "PagerViewController.h"

@interface PagerViewController ()
@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;
- (void)loadScrollViewWithPage:(int)page;
@end

@implementation PagerViewController

@synthesize scrollView;
@synthesize pageControl;
@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    offset = 0.0;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-20, 0, 360, [[UIScreen mainScreen] bounds].size.height-100)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(360*[self.childViewControllers count], [[UIScreen mainScreen] bounds].size.height-100);
    
    for (int i = 0; i<[self.childViewControllers count]; i++){
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(360*i, 0, 360, [[UIScreen mainScreen] bounds].size.height-100)];
        s.backgroundColor = [UIColor clearColor];
        s.contentSize = CGSizeMake(360, [[UIScreen mainScreen] bounds].size.height-100);
        s.showsHorizontalScrollIndicator = NO;
        s.showsVerticalScrollIndicator = NO;
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 3.0;
        s.tag = i+1;
        [s setZoomScale:1.0];
        
        UIViewController *controller = [self.childViewControllers objectAtIndex:i];
        controller.view.frame = CGRectMake(20, 0, 320, [[UIScreen mainScreen] bounds].size.height-100);
        [controller.view setContentMode:UIViewContentModeScaleAspectFit];
        controller.view.userInteractionEnabled = YES;
        controller.view.tag = i+1;
        [controller.view addGestureRecognizer:doubleTap];
        [s addSubview:controller.view];
        
        [self.scrollView addSubview:s];
        
        [doubleTap release];
        [s release];
    }
    
    [self.view addSubview:self.scrollView];

	/*
	for (NSUInteger i =0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
	self.pageControl.currentPage = 0;
	_page = 0;
	[self.pageControl setNumberOfPages:[self.childViewControllers count]];
	
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillAppear:animated];
	}
	
	self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.childViewControllers count], scrollView.frame.size.height);*/
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if ([self.childViewControllers count]) {
		UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
		if (viewController.view.superview != nil) {
			[viewController viewDidAppear:animated];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	if ([self.childViewControllers count]) {
		UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
		if (viewController.view.superview != nil) {
			[viewController viewWillDisappear:animated];
		}
	}
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidDisappear:animated];
	}
	[super viewDidDisappear:animated];
}
/*
- (void)loadScrollViewWithPage:(int)page {
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
	// replace the placeholder if necessary
    UIViewController *controller = [self.childViewControllers objectAtIndex:page];
    if (controller == nil) {
		return;
    }
	
	// add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}
*/
- (void)previousPage {
	if (_page - 1 > 0) {
	
		// update the scroll view to the appropriate page
		CGRect frame = self.scrollView.frame;
		frame.origin.x = frame.size.width * (_page - 1);
		frame.origin.y = 0;
		
		UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
		UIViewController *newViewController = [self.childViewControllers objectAtIndex:_page - 1];
		[oldViewController viewWillDisappear:YES];
		[newViewController viewWillAppear:YES];
		
		[self.scrollView scrollRectToVisible:frame animated:YES];
		
		self.pageControl.currentPage = _page - 1;
		// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
		_pageControlUsed = YES;
	}
}

- (void)nextPage {
	if (_page + 1 > self.pageControl.numberOfPages) {
		
		// update the scroll view to the appropriate page
		CGRect frame = self.scrollView.frame;
		frame.origin.x = frame.size.width * (_page + 1);
		frame.origin.y = 0;
		
		UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
		UIViewController *newViewController = [self.childViewControllers objectAtIndex:_page + 1];
		[oldViewController viewWillDisappear:YES];
		[newViewController viewWillAppear:YES];
		
		[self.scrollView scrollRectToVisible:frame animated:YES];
		
		self.pageControl.currentPage = _page + 1;
		// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
		_pageControlUsed = YES;
	}
}

- (IBAction)changePage:(id)sender {
    int page = ((UIPageControl *)sender).currentPage;
	
	// update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
	UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
	UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	[oldViewController viewWillDisappear:YES];
	[newViewController viewWillAppear:YES];
	
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    _pageControlUsed = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
	UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	[oldViewController viewDidDisappear:YES];
	[newViewController viewDidAppear:YES];
	
	_page = self.pageControl.currentPage;
}

-(NSString *)displayContent:(int) tag
{

    return @"02-24622192p9";
}

-(NSString *)displayTitle:(int) tag
{
    switch (tag) {
        case 1:
            return @"豪嘉粥品";
            break;
        case 2:
            return @"日久阿囉哈";
            break;
        case 3:
            return @"北寧早餐店";
            break;
        case 4:
            return @"北寧牙科";
            break;
        case 5:
            return @"振煒車業";
            break;
        case 6:
            return @"優速影像輸出";
            break;
        case 7:
            return @"東方影印";
            break;
        case 8:
            return @"東北機車";
            break;
        case 9:
            return @"美姿客披薩";
            break;
        case 10:
            return @"加油站";
            break;
        case 11:
            return @"全聯福利中心";
            break;
        case 12:
            return @"海洋診所";
            break;
        case 13:
            return @"仁人診所";
            break;
        case 14:
            return @"OK便利商店";
            break;
        case 15:
            return @"哈樂百貨買場";
            break;
        case 16:
            return @"阿玉炒飯";
            break;
        case 17:
            return @"佬地方牛排";
            break;
        case 18:
            return @"清新福全";
            break;
        case 19:
            return @"新嘉村用品行";
            break;
        case 20:
            return @"隆成機車";
            break;
        case 21:
            return @"中正區衛生所";
            break;
        case 22:
            return @"鴨香寶燒臘";
            break;
        case 23:
            return @"奶鍋的店";
            break;
        case 24:
            return @"鼎乃鮮小火鍋";
            break;
        case 25:
            return @"全德眼鏡";
            break;
        case 26:
            return @"煎茶水記";
            break;
        case 27:
            return @"合成便當";
            break;
        case 28:
            return @"超大杯甜品屋";
            break;
        case 29:
            return @"星翔快餐店";
            break;
        case 30:
            return @"2d水飲品";
            break;
        case 31:
            return @"三媽臭臭鍋";
            break;
        case 32:
            return @"ComeBuy";
            break;
        case 33:
            return @"捌壹捌麵館";
            break;
        case 34:
            return @"加油站";
            break;
        case 35:
            return @"超級雞車";
            break;
        case 36:
            return @"港式燒臘";
            break;
        case 37:
            return @"食神涮涮鍋";
            break;
        case 38:
            return @"7-11便利商店";
            break;
        case 39:
            return @"全家便利商店";
            break;
        case 40:
            return @"弘揚電腦維修";
            break;
        case 41:
            return @"海洋麵店";
            break;
        case 42:
            return @"陽光早餐店";
            break;
        case 43:
            return @"富而美早餐店";
            break;
        case 44:
            return @"20元麵店";
            break;
        case 45:
            return @"北海影印";
            break;
        case 46:
            return @"早安媽美食館";
            break;
        case 47:
            return @"光泰影印";
            break;
        case 48:
            return @"早午餐專賣";
            break;
        case 49:
            return @"阿邦燒臘";
            break;
        case 50:
            return @"泰式酸辣麵";
            break;
        case 51:
            return @"微笑11炭烤";
            break;
        case 52:
            return @"正老店鹽酥雞/炭烤";
            break;
        case 53:
            return @"專業麵疙瘩";
            break;
        case 54:
            return @"好了啦紅茶冰";
            break;
        case 55:
            return @"超羣滷味/鹽酥雞";
            break;
        case 56:
            return @"瑞麟美而美";
            break;
        case 57:
            return @"早安美芝城";
            break;
        case 58:
            return @"益文影印/文具";
            break;
        case 59:
            return @"切仔麵";
            break;
        case 60:
            return @"愛買";
            break;
        case 61:
            return @"屈臣氏";
            break;
        case 62:
            return @"QQ滷肉飯";
            break;
        case 63:
            return @"饕客便當";
            break;
        case 64:
            return @"康是美";
            break;
        case 65:
            return @"7-11便利商店";
            break;
        case 66:
            return @"大麥穗法式烘培坊";
            break;
        case 67:
            return @"張師傅專業烘培";
            break;
        case 68:
            return @"ComeBuy";
            break;
        case 69:
            return @"樂氣球桌遊";
            break;
        case 70:
            return @"全家便利商店";
            break;
        case 71:
            return @"十三鼎風味小火鍋";
            break;
        case 72:
            return @"新豐郵局";
            break;
        case 73:
            return @"頂好超市";
            break;
        case 74:
            return @"董娘精緻水餃";
            break;
        case 75:
            return @"八方雲集";
            break;

        default:
            break;
    }
    return nil;
}

-(IBAction)displayInfomation:(id)sender
{
    UIButton* button = sender;
    if (button.tag) {
        UIAlertView *loadingAlertView = [[UIAlertView alloc]
                                         initWithTitle:[self displayTitle:button.tag]message:[self displayContent:button.tag]
                                         delegate:self cancelButtonTitle:@"確定"
                                         otherButtonTitles:@"撥號"];
        [loadingAlertView show];
        [loadingAlertView release];
    }
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (_pageControlUsed || _rotating) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if (self.pageControl.currentPage != page) {
		UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
		UIViewController *newViewController = [self.childViewControllers objectAtIndex:page];
		[oldViewController viewWillDisappear:YES];
		[newViewController viewWillAppear:YES];
		self.pageControl.currentPage = page;
		[oldViewController viewDidDisappear:YES];
		[newViewController viewDidAppear:YES];
		_page = page;
	}
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)View{
    
    for (UIView *v in View.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)View{
    _pageControlUsed = NO;
    if (View == self.scrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
            
        }
        else {
            offset = x;
            for (UIScrollView *s in View.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                    UIImageView *image = [[s subviews] objectAtIndex:0];
                    image.frame = CGRectMake(20, 0, 320, [[UIScreen mainScreen] bounds].size.height-100);
                }
            }
        }
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    UIView *v = [scrollView.subviews objectAtIndex:0];
    if ([v isKindOfClass:[UIImageView class]]){
        if (scrollView.zoomScale<1.0){
            //         v.center = CGPointMake(scrollView.frame.size.width/2.0, scrollView.frame.size.height/2.0);
        }
    }
}

#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    UIView *view = gesture.view.superview;
    if ([view isKindOfClass:[UIScrollView class]]){
        UIScrollView *s = (UIScrollView *)view;
        [s zoomToRect:zoomRect animated:YES];
    }
}

#pragma mark - Utility methods

-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

-(CGRect)resizeImageSize:(CGRect)rect{
    //    NSLog(@"x:%f y:%f width:%f height:%f ", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGRect newRect;
    
    CGSize newSize;
    CGPoint newOri;
    
    CGSize oldSize = rect.size;
    if (oldSize.width>=320.0 || oldSize.height>=460.0){
        float scale = (oldSize.width/320.0>oldSize.height/460.0?oldSize.width/320.0:oldSize.height/460.0);
        newSize.width = oldSize.width/scale;
        newSize.height = oldSize.height/scale;
    }
    else {
        newSize = oldSize;
    }
    newOri.x = (320.0-newSize.width)/2.0;
    newOri.y = (460.0-newSize.height)/2.0;
    
    newRect.size = newSize;
    newRect.origin = newOri;
    
    return newRect;
}


@end
