//
//  LessonTimeView.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/26.
//
//

#import "LessonTimeView.h"
#import "ClassDataBase.h"
@implementation LessonTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for(UIView *subview in [self subviews])
    {
        [subview removeFromSuperview];
    }
    
    NSArray* content= [[ClassDataBase sharedData] ShowClassTimes];
    
    for (int i=0;i<[[ClassDataBase sharedData] FetchClassSessionTimes];i++) {
        
        CGRect labelFrame ;
        labelFrame = CGRectMake( 0,(LeftViewHeight-TextLabelborderWidth)*i, LeftBaseline, LeftViewHeight );
        UILabel* label = [[[UILabel alloc] initWithFrame: labelFrame] autorelease];
        label.text = [content objectAtIndex:i];
        label.backgroundColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1];
        if (i==4){
            label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
            label.textColor = [UIColor whiteColor];
        }
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.textAlignment = UITextAlignmentCenter;
        if ([[ClassDataBase sharedData]FetchshowClassTimes]) {
            label.font = [UIFont fontWithName:@"AppleGothic" size:9];
        } else {
            label.font = [UIFont fontWithName:@"AppleGothic" size:13];
        }
        label.layer.borderWidth = TextLabelborderWidth;
        label.numberOfLines=0;
        label.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview: label];
    }
}


@end
