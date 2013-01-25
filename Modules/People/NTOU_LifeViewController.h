//
//  NTOU_LifeViewController.h
//  NTOUMobile
//
//  Created by R MAC on 13/1/24.
//
//

#import <UIKit/UIKit.h>

@interface NTOU_LifeViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIImageView *jungjeng;
    IBOutlet UIImageView *shinfeng;
    IBOutlet UIImageView *shiangfeng;
    IBOutlet UIImageView *beining;
}

@end
