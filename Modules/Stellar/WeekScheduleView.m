//
//  WeekScheduleView.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "WeekScheduleView.h"
#import "ClassDataBase.h"
@implementation WeekScheduleView
@synthesize WhetherTapped;
@synthesize parent_ViewController;
@class ScheduleViewController;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        color = [[NSArray arrayWithObjects:[UIColor colorWithRed:193.0/255 green:255.0/255 blue:193.0/255 alpha:1],[UIColor colorWithRed:248.0/255 green:248.0/255 blue:255.0/255 alpha:1],[UIColor colorWithRed:255.0/255 green:248.0/255 blue:220.0/255 alpha:1],[UIColor colorWithRed:245.0/255 green:255.0/255 blue:250.0/255 alpha:1],[UIColor colorWithRed:255.0/255 green:255.0/255 blue:224.0/255 alpha:1],[UIColor colorWithRed:255.0/255 green:246.0/255 blue:143.0/255 alpha:1],[UIColor colorWithRed:255.0/255 green:181.0/255 blue:197.0/255 alpha:1],[UIColor colorWithRed:255.0/255 green:187.0/255 blue:255.0/255 alpha:1],[UIColor colorWithRed:224.0/255 green:255.0/255 blue:255.0/255 alpha:1],[UIColor colorWithRed:135.0/255 green:226.0/255 blue:255.0/255 alpha:1], nil] retain];
}
   
    return self;
}

-(void)getParent_ViewController:(ScheduleViewController *)recieve{
    parent_ViewController = recieve;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


-(IBAction)labelTapped:(id)sender
{
    UIGestureRecognizer * tapGesture = (UIGestureRecognizer *)sender;
    ClassLabelBasis*label = (ClassLabelBasis*)[self viewWithTag:tapGesture.view.tag];
    if (WhetherTapped) {
        if (label.changeColor) {
            label.backgroundColor = label.tempBackground;
            label.changeColor = NO;
        } else {
            label.backgroundColor = [UIColor colorWithRed:187.0/255 green:255.0/255 blue:255.0/255 alpha:1];
            label.changeColor = YES;
        }
    }
    else {
        [parent_ViewController showClassInfo:label];
    }
    
}

-(void)drawColumnTextLabelNumber:(NSInteger)number Content:(NSArray *)content {

    for (int i=0;i<[content count] && i < [[ClassDataBase sharedData] FetchClassSessionTimes] && number<[[ClassDataBase sharedData]FetchWeekTimes];i++) {
        int sameClass=i;
        while (1) {
            if (i+1<[content count] ) {
                if ([[content objectAtIndex:i+1] isEqualToString:[content objectAtIndex:i]]&&![[content objectAtIndex:i]isEqualToString:@" "]) {
                    i++;
                }
                else
                    break;
            }
            else
                break;
        }
        CGRect labelFrame ;
        int x=0;
        if ([parent_ViewController NavigationBarHidden]) {
            x=44;
        }
        labelFrame = CGRectMake( LeftBaseline+number*(UpperViewWidth-TextLabelborderWidth), x+UpperBaseline+(LeftViewHeight-TextLabelborderWidth)*sameClass, UpperViewWidth, LeftViewHeight+(LeftViewHeight-TextLabelborderWidth)*(i-sameClass));
        ClassLabelBasis* label = [[[ClassLabelBasis alloc] initWithFrame: labelFrame] autorelease];
        label.text = [content objectAtIndex:i];
        label.backgroundColor = [color objectAtIndex:(number+i)%10];
        NSLog(@"%@",label.backgroundColor);
        if ([[content objectAtIndex:i] isEqualToString:@" "]){
            label.backgroundColor = [UIColor clearColor];
        }
        if (i==4&&[[content objectAtIndex:i]isEqualToString:@" "])
            label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.font = [UIFont fontWithName:@"AppleGothic" size:15];
        label.tag = (number*100+sameClass)*100+i-sameClass+1;
        label.textAlignment = UITextAlignmentCenter;
        label.layer.borderWidth = TextLabelborderWidth;
        label.tempBackground = label.backgroundColor;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [label addGestureRecognizer:tapGestureRecognizer];
        label.userInteractionEnabled = YES;
        [tapGestureRecognizer release];
        label.numberOfLines=0;
        label.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview: label];
    }
}



- (void)drawRect:(CGRect)rect
{
    for(UIView *subview in [self subviews])
    {
        [subview removeFromSuperview];
    }
    NSDictionary * scheduleInfo = [[ClassDataBase sharedData] FetchScheduleInfo];
    int ColumnNumber=0;
    if ([[ClassDataBase sharedData] displayWeekDays:Monday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Monday"]];
    if ([[ClassDataBase sharedData] displayWeekDays:Tuesday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Tuesday"]];
    if ([[ClassDataBase sharedData] displayWeekDays:Wednesday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Wednesday"]];
    if ([[ClassDataBase sharedData] displayWeekDays:Thursday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Thursday"]];
    if ([[ClassDataBase sharedData] displayWeekDays:Friday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Friday"]];
    if ([[ClassDataBase sharedData] displayWeekDays:Saturday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Saturday"]];
    if ([[ClassDataBase sharedData] displayWeekDays:Sunday])
        [self drawColumnTextLabelNumber:ColumnNumber++ Content:[scheduleInfo objectForKey:@"Sunday"]];
    [super drawRect:rect];
}


@end
