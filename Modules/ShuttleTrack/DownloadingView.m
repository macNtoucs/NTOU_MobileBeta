//
//  DownloadingView.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/20.
//
//

#import "DownloadingView.h"

@implementation DownloadingView

-(void)AlertViewStart{
    loadingAlertView = [[UIAlertView alloc]
                        initWithTitle:nil message:@"\n\n下載資料中\n請稍待"
                        delegate:nil cancelButtonTitle:@"取消"
                        otherButtonTitles: nil,nil];
    [loadingAlertView retain];
    CGRect frame = CGRectMake(120, 10, 40, 40);
    UIActivityIndicatorView* progressInd = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [progressInd startAnimating];
    [loadingAlertView addSubview:progressInd];
    [loadingAlertView show];
    [progressInd release];
}

-(void)AlertViewEnd{
    [loadingAlertView dismissWithClickedButtonIndex:0 animated:NO];
    [loadingAlertView release];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) [self AlertViewEnd];
}
@end
