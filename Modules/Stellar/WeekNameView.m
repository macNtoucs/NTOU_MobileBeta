//
//  WeekNameView.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "WeekNameView.h"

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
    NSArray* Array = [NSArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"Mon"],[NSString stringWithFormat:@"Tue"],[NSString stringWithFormat:@"Wed"],[NSString stringWithFormat:@"Thu"],[NSString stringWithFormat:@"Fri"],[NSString stringWithFormat:@"Sat"],nil];
    for (int i=0;i<7;i++) {
        CGRect labelFrame ;
        if (i)
            labelFrame = CGRectMake( 55+(i-1)*88, 0, 90, 40 );
        else
            labelFrame = CGRectMake( 0.5, 0, 55, 40 );
        UILabel* label = [[[UILabel alloc] initWithFrame: labelFrame] autorelease];
        label.text = [Array objectAtIndex:i];
        if (i)
            label.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        else
            label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = 2;
        
        [self addSubview: label];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawRowWeekNameTextLabel];
    [super drawRect:rect];
    // Drawing code
}


@end
