//
//  AFPickerView.m
//  PickerView
//
//  Created by Fraerman Arkady on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StationPickerPickerView.h"

@implementation StationPickerPickerView

#pragma mark - Synthesization

@synthesize dataSource;
@synthesize delegate;
@synthesize selectedRow = currentRow;
@synthesize rowFont = _rowFont;
@synthesize rowIndent = _rowIndent;
@synthesize currentLabel;
bool initailIndex = true;


#pragma mark - Custom getters/setters



- (void)setRowFont:(UIFont *)rowFont
{
    _rowFont = [UIFont boldSystemFontOfSize:20];
   
    for (UILabel *aLabel in visibleViews)
    {
         aLabel.font = _rowFont;
        
    }
    
    for (UILabel *aLabel in recycledViews) 
    {
        aLabel.font = _rowFont;
    }
}




- (void)setRowIndent:(CGFloat)rowIndent
{
    _rowIndent = rowIndent;
    
    for (UILabel *aLabel in visibleViews) 
    {
        CGRect frame = aLabel.frame;
        frame.origin.x = 53;
        frame.size.width = self.frame.size.width - _rowIndent;
        aLabel.frame = frame;
    }
    
    for (UILabel *aLabel in recycledViews) 
    {
        CGRect frame = aLabel.frame;
        frame.origin.x = 53;
        frame.size.width = self.frame.size.width - _rowIndent;
        aLabel.frame = frame;
    }
}




#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // setup
        [self setup];
        isScrollingUp=false;
        // backgound
        UIImageView *bacground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StationPickerBackground1.png"]];
        [self addSubview:bacground];
        
        // content
        rowsCount = [dataSource numberOfRowsInPickerView:self];
        contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0, frame.size.width, frame.size.height)];
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.delegate = self;
        contentView.contentSize =
        CGSizeMake(contentView.frame.size.width, (glassHeight *rowsCount) + (4 * glassHeight));
        [self addSubview:contentView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [contentView addGestureRecognizer:tapRecognizer];
        
        
        // shadows
        UIImageView *shadows = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StationPickerBackgroundShadows.png"]];
        [self addSubview:shadows];
        
        currentLabel = [UILabel new];
    }
    return self;
}




- (void)setup
{
    _rowFont = [UIFont boldSystemFontOfSize:20.0];
    _rowIndent = 60;
    
    currentRow = [dataSource initialRow:self];
    rowsCount = 0;
}




#pragma mark - Buisness

- (void)reloadData
{
    // empry views
    currentRow = [dataSource initialRow:self];
    rowsCount = 0;
    for (UIView *aView in visibleViews)
        [aView removeFromSuperview];
    
    for (UIView *aView in recycledViews)
        [aView removeFromSuperview];
    
    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];
    
    rowsCount = [dataSource numberOfRowsInPickerView:self];
     [contentView setContentOffset:CGPointMake(0.0, glassHeight*(currentRow-2)-10) animated:NO];
    contentView.contentSize =
    CGSizeMake(contentView.frame.size.width, (glassHeight *rowsCount) + (4 * glassHeight));
    isScrollingUp=true;
    [self tileViews];
     
}




- (void)determineCurrentRow
{
    CGFloat delta = contentView.contentOffset.y;
    int position = round(delta / glassHeight);
    currentRow = position+1;
    [contentView setContentOffset:CGPointMake(0.0, glassHeight * (position-1) - 10) animated:YES];
    [delegate pickerView:self didSelectRow:currentRow];
}




- (void)didTap:(id)sender
{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    CGPoint point = [tapRecognizer locationInView:self];
    int steps = floor(point.y / glassHeight) - 3;
    [self makeSteps:steps];
}




- (void)makeSteps:(int)steps
{
    if (steps == 0 || steps > 4 || steps < -4)
        return;
    
 
    currentRow = currentRow + steps;
    if (currentRow>rowsCount  || currentRow <1)return;
    [contentView setContentOffset:CGPointMake(0.0, glassHeight*(currentRow-2)-10) animated:YES];
      [delegate pickerView:self didSelectRow:currentRow-1];
    isScrollingUp=true;
    for (UILabel * invisible in visibleViews ){
        invisible.textColor = RGBACOLOR(0.0, 0.0, 0.0, 0.75);
        invisible.font = [UIFont boldSystemFontOfSize:20];
    }
    for ( UILabel *currentLabel_tmp in visibleViews){
        if (isScrollingUp){
            NSString * nowSelected = [dataSource pickerView:self nowSelected:currentRow];
            if ([currentLabel_tmp.text isEqualToString: nowSelected]) {
                currentLabel=currentLabel_tmp;
                isScrollingUp = false;
                currentLabel.font = [UIFont boldSystemFontOfSize:25];
                currentLabel.textColor = RGBACOLOR(255,255,255, 1);
                break;
            }
            else {
                currentLabel_tmp.textColor = RGBACOLOR(0.0, 0.0, 0.0, 0.75);
                currentLabel_tmp.font = [UIFont boldSystemFontOfSize:20];
            }
        }
    }
   
 
}
-(void)nowSelectedChangeStyle{

}

#pragma mark - recycle queue

- (UIView *)dequeueRecycledView
{
	UIView *aView = [recycledViews anyObject];
	
    if (aView) 
        [recycledViews removeObject:aView];
    return aView;
}



- (BOOL)isDisplayingViewForIndex:(NSUInteger)index
{
	BOOL foundPage = NO;
    for (UIView *aView in visibleViews) 
	{
        int viewIndex = aView.frame.origin.y / glassHeight - 2;
        if (viewIndex == index) 
		{
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}




- (void)tileViews
{
    // Calculate which pages are visible
    CGRect visibleBounds = contentView.bounds;
    
    int firstNeededViewIndex = floorf(CGRectGetMinY(visibleBounds) / glassHeight) - 2;
    int lastNeededViewIndex  = floorf((CGRectGetMaxY(visibleBounds) / glassHeight)) - 2;
    firstNeededViewIndex = MAX(firstNeededViewIndex, 0);
    lastNeededViewIndex  = MIN(lastNeededViewIndex, rowsCount - 1);
	
    // Recycle no-longer-visible pages 
	for (UIView *aView in visibleViews)
    {
        int viewIndex = aView.frame.origin.y / glassHeight - 2;
        if (viewIndex < firstNeededViewIndex || viewIndex > lastNeededViewIndex) 
        {
            [recycledViews addObject:aView];
            [aView removeFromSuperview];
        }
        
     }
    
   
    for ( UILabel *currentLabel_tmp in visibleViews){
        if (isScrollingUp){
            NSString * nowSelected = [dataSource pickerView:self nowSelected:currentRow];
            if ([currentLabel_tmp.text isEqualToString: nowSelected]) {
                currentLabel=currentLabel_tmp;
                isScrollingUp = false;
                currentLabel.font = [UIFont boldSystemFontOfSize:25];
                currentLabel.textColor = RGBACOLOR(255,255, 255, 1);
               }
            else {
                currentLabel_tmp.textColor = RGBACOLOR(0.0, 0.0, 0.0, 0.75);
                currentLabel_tmp.font = [UIFont boldSystemFontOfSize:20];
            }
        }
       }
    for (UILabel * invisible in recycledViews ){
       invisible.textColor = RGBACOLOR(0.0, 0.0, 0.0, 0.75);
        invisible.font = [UIFont boldSystemFontOfSize:20];
    }
   
    //NSLog(@"%@",currentLabel);
    [visibleViews minusSet:recycledViews];
    
    // add missing pages
	for (int index = firstNeededViewIndex; index <= lastNeededViewIndex; index++) 
	{
        if (![self isDisplayingViewForIndex:index]) 
		{
            UILabel *label = (UILabel *)[self dequeueRecycledView];
            
			if (label == nil)
            {
				label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - _rowIndent, glassHeight)];
                label.backgroundColor = [UIColor clearColor];
                label.font = _rowFont;
                label.textColor = RGBACOLOR(0.0, 0.0, 0.0, 0.75);
                /*if (index==1 && isreload){
                    label.font = [UIFont boldSystemFontOfSize:25];
                    //label.textColor = RGBACOLOR(255, 255,255,1);
                    isreload = false;
                }*/
            }
            
            [self configureView:label atIndex:index];
            [contentView addSubview:label];
            [visibleViews addObject:label];
        }
    }
}




- (void)configureView:(UIView *)view atIndex:(NSUInteger)index
{
    UILabel *label = (UILabel *)view;
    label.text = [dataSource pickerView:self titleForRow:index];
    CGRect frame = label.frame;
    frame.origin.y = glassHeight * index + glassHeight*2;
    frame.origin.x = 53;
    label.frame = frame;
}




#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tileViews];
}




- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    isScrollingUp=true;
    if (!decelerate)
        [self determineCurrentRow];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isScrollingUp=true;
    [self determineCurrentRow];
   
}

@end
