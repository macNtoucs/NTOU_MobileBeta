//
//  WeekScheduleView.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "WeekScheduleView.h"

@implementation WeekScheduleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect labelFrame = CGRectMake( 10, 40, 100, 30 );
    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
    [label setText: @"My Label"];
    
    
    [self addSubview: label];
    
    [super drawRect:rect];
}


@end
