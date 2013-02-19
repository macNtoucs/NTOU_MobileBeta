//
//  NTOU_LifeViewController.m
//  NTOUMobile
//
//  Created by R MAC on 13/1/24.
//
//

#import "NTOU_LifeViewController.h"

@interface NTOU_LifeViewController ()

@end

@implementation NTOU_LifeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"NTOU_Life" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];/*
    pageControl = [UIPageControl new];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, 480)];
    [pageControl setNumberOfPages:4];
    [pageControl setCurrentPage:0];
    
    //UIScrollView設定
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollsToTop:NO];
    [scrollView setDelegate:self];
    
    CGFloat width, height;
    width = scrollView.frame.size.width;
    height = scrollView.frame.size.height;
    [scrollView setContentSize:CGSizeMake(width * 4, height)];
    
    //製作ScrollView的內容
     UIImage * img = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"beining" ofType:@"jpg"]];
    beining = [[[UIImageView alloc] initWithImage:img] autorelease];
    beining.frame = CGRectMake(0, 0, width, height);
    [scrollView addSubview:beining];
     img = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"jungjeng" ofType:@"jpg"]];
    jungjeng = [[[UIImageView alloc] initWithImage:img] autorelease];
    jungjeng.frame = CGRectMake(320, 0, width, height);
    [scrollView addSubview:jungjeng];

     img = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shiangfeng" ofType:@"jpg"]];
    shiangfeng = [[[UIImageView alloc] initWithImage:img] autorelease];
    shiangfeng.frame = CGRectMake(640, 0, width, height);
    [scrollView addSubview:shiangfeng];

     img = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shinfeng" ofType:@"jpg"]];
    shinfeng = [[[UIImageView alloc] initWithImage:img] autorelease];
    shinfeng.frame = CGRectMake(960, 0, width, height);
    [scrollView addSubview:shinfeng];

               
        
    [self.view addSubview:scrollView];*/
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat width = scrollView.frame.size.width;
    NSInteger currentPage = ((scrollView.contentOffset.x - width / 2) / width) + 1;
    [pageControl setCurrentPage:currentPage];
}

- (IBAction)changeCurrentPage:(UIPageControl *)sender {
    NSInteger page = pageControl.currentPage;
    
    CGFloat width, height;
    width = scrollView.frame.size.width;
    height = scrollView.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    
    [scrollView scrollRectToVisible:frame animated:YES];
}

//页面控制方法
-(IBAction) pageChanged{
    
    switch ([pageControl currentPage]) {
			
		case 0:
			[shinfeng removeFromSuperview];
			[shiangfeng removeFromSuperview];
            [beining removeFromSuperview];
			[[self view] addSubview:jungjeng];
			break;
			
		case 1:
			[jungjeng removeFromSuperview];
			[shiangfeng removeFromSuperview];
            [beining removeFromSuperview];
			[[self view] addSubview:shinfeng];
			break;
			
		case 2:
			[shinfeng removeFromSuperview];
			[jungjeng removeFromSuperview];
            [beining removeFromSuperview];
			[[self view] addSubview:shiangfeng];
			break;
        
        case 3:
			[shinfeng removeFromSuperview];
			[shiangfeng removeFromSuperview];
            [jungjeng removeFromSuperview];
			[[self view] addSubview:beining];
			break;

			
		default:
			break;
	}
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)dealloc {
    [beining release];
    [pageControl release];
    [scrollView release];
    [shinfeng release];
    [shiangfeng release];
    [jungjeng release];
    [super dealloc];
}*/
- (void)viewDidUnload {
    [beining release];
    beining = nil;
    [pageControl release];
    pageControl = nil;
    [scrollView release];
    scrollView = nil;
    [shinfeng release];
    shinfeng = nil;
    [shiangfeng release];
    shiangfeng = nil;
    [jungjeng release];
    jungjeng = nil;
    [super viewDidUnload];
}
@end
