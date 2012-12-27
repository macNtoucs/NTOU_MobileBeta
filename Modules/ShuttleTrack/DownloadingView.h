//
//  DownloadingView.h
//  MIT Mobile
//
//  Created by MacAir on 12/11/20.
//
//

#import <Foundation/Foundation.h>

@interface DownloadingView : NSObject<UIAlertViewDelegate>{
 UIAlertView *loadingAlertView;

}
-(void)AlertViewStart;
-(void)AlertViewEnd;
@end
