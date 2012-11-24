//
//  WeekNameView.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "WeekNameView.h"
#import "ClassDataBase.h"
@implementation WeekNameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRowWeekNameTextLabel{
    NSArray* Array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"Mon"],[NSString stringWithFormat:@"Tue"],[NSString stringWithFormat:@"Wed"],[NSString stringWithFormat:@"Thu"],[NSString stringWithFormat:@"Fri"],[NSString stringWithFormat:@"Sat"],[NSString stringWithFormat:@"Sun"],nil];
    for (int i=0,j=0;i<7;i++) {
        if (![[ClassDataBase sharedData] displayWeekDays:i]) {
            continue;
        }
        CGRect labelFrame ;
        labelFrame = CGRectMake( j++*(UpperViewWidth-TextLabelborderWidth), 0, UpperViewWidth,  UpperBaseline);
            //labelFrame = CGRectMake( 0, 0, 55, 40 );
        UILabel* label = [[[UILabel alloc] initWithFrame: labelFrame] autorelease];
        label.text = [Array objectAtIndex:i];
        label.backgroundColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1];
            //label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        label.textAlignment = UITextAlignmentCenter;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = TextLabelborderWidth;
        
        [self addSubview: label];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for(UIView *subview in [self subviews])
    {
        [subview removeFromSuperview];
    }
    [self drawRowWeekNameTextLabel];
    [super drawRect:rect];
    // Drawing code
}


@end
