//
//  AFPickerView.h
//  PickerView
//
//  Created by Fraerman Arkady on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define glassHeight 60
@protocol StationPickerPickerViewDataSource;
@protocol StationPickerPickerViewDelegate;

@interface StationPickerPickerView : UIView <UIScrollViewDelegate>
{
    __unsafe_unretained id <StationPickerPickerViewDataSource> dataSource;
    __unsafe_unretained id <StationPickerPickerViewDelegate> delegate;
    UIScrollView *contentView;
    UIImageView *glassImageView;
    
    int currentRow;
    int rowsCount; 
    
    CGPoint previousOffset;
    BOOL isScrollingUp;
    
    // recycling
    NSMutableSet *recycledViews;
    NSMutableSet *visibleViews;
    
    UIFont *_rowFont;
    CGFloat _rowIndent;
    
    UILabel * currentLabel;
    float lastContentOffset;
    bool isStopScroll;
}

@property (nonatomic, unsafe_unretained) id <StationPickerPickerViewDataSource> dataSource;
@property (nonatomic, unsafe_unretained) id <StationPickerPickerViewDelegate> delegate;
@property (nonatomic, unsafe_unretained) int selectedRow;
@property (nonatomic, strong) UIFont *rowFont;
@property (nonatomic, unsafe_unretained) CGFloat rowIndent;
@property (nonatomic ,strong) UILabel * currentLabel;

- (void)setup;
- (void)reloadData;
- (void)determineCurrentRow;
- (void)didTap:(id)sender;
- (void)makeSteps:(int)steps;

// recycle queue
- (UIView *)dequeueRecycledView;
- (BOOL)isDisplayingViewForIndex:(NSUInteger)index;
- (void)tileViews;
- (void)configureView:(UIView *)view atIndex:(NSUInteger)index;

@end



@protocol StationPickerPickerViewDataSource <NSObject>

- (NSInteger)numberOfRowsInPickerView:(StationPickerPickerView *)pickerView;
- (NSString *)pickerView:(StationPickerPickerView *)pickerView titleForRow:(NSInteger)row;
- (NSString *) pickerView : (StationPickerPickerView *) pickerView nowSelected:(NSInteger) row;
@end



@protocol StationPickerPickerViewDelegate <NSObject>

- (void)pickerView:(StationPickerPickerView *)pickerView didSelectRow:(NSInteger)row;

@end