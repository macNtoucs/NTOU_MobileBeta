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
    NSArray* Array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"Mon"],[NSString stringWithFormat:@"Tue"],[NSString stringWithFormat:@"Wed"],[NSString stringWithFormat:@"Thu"],[NSString stringWithFormat:@"Fri"],[NSString stringWithFormat:@"Sat"],nil];
    for (int i=0;i<6;i++) {
        CGRect labelFrame ;
        labelFrame = CGRectMake( i*58, 0, 60, 40 );
            //labelFrame = CGRectMake( 0, 0, 55, 40 );
        UILabel* label = [[[UILabel alloc] initWithFrame: labelFrame] autorelease];
        label.text = [Array objectAtIndex:i];
        label.backgroundColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1];
            //label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
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
