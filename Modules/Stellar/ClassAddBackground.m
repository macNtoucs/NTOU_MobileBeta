//
//  ClassAddBackground.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/30.
//
//

#import "ClassAddBackground.h"

@implementation ClassAddBackground

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
    CGPoint x1=CGPointMake(0, 60),x2=CGPointMake(320, 370);
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
