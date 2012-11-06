//
//  ThroughTap.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/7.
//
//

#import "ThroughTap.h"

@implementation ThroughTap

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint x1=CGPointMake(10, 10),x2=CGPointMake(315, 345);
    if (x1.x<point.x&&x1.y<point.y&&point.x<x2.x&&point.y<x2.y) {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
