//
//  ClassInfoView.h
//  MIT Mobile
//
//  Created by mini server on 12/11/3.
//
//
@class ReaderViewController;

@protocol ClassInfoViewDelegate <NSObject>

@required
-(void)rightBarButtonItemOn;
-(void)rightBarButtonItemOff;
-(void)presentOn:(ReaderViewController*)ViewController;
-(void)presentOff;
@end

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import "MITUIConstants.h"
#import "ReaderViewController.h"
#define type1 @"成績"
#define type2 @"作業"
#define type3 @"公告"
#define type4 @"講義"
#define type5 @"筆記"
#define type6 @"考古題"

@interface ClassInfoView : UITableViewController<UITextViewDelegate,ReaderViewControllerDelegate>
{
    UITextView *textView;
    NSDictionary* moodleData;
    id delegatetype5;
    NSMutableArray* resource;
}

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) NSDictionary* moodleData;
@property (nonatomic, retain) NSMutableArray* resource;
@property (nonatomic,assign) id delegatetype5;
@end
