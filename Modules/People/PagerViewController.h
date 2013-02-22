//
//  ViewController.h
//  PageViewController
//
//  Created by Tom Fewster on 11/01/2012.
//

#import <UIKit/UIKit.h>

@interface PagerViewController : UIViewController <UIScrollViewDelegate>
{
    CGFloat offset;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;
-(IBAction)displayInfomation:(id)sender;
- (void)previousPage;
- (void)nextPage;

@end
