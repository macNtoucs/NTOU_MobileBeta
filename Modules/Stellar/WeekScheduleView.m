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
@synthesize TapAddCourse;
@synthesize parent_ViewController;
@class ScheduleViewController;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        TapAddCourse = [[NSMutableArray alloc] init];
        course = [[NSMutableArray alloc] init];
        color = [[ClassDataBase sharedData] FetchColorDic];
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


-(void)restorTheOriginalColor
{
    for (ClassLabelBasis* courselabel in TapAddCourse){
        courselabel.backgroundColor = courselabel.tempBackground;
        courselabel.changeColor = NO;
    }
    [TapAddCourse removeAllObjects];
}

-(void)removeAllcourselabel
{
    for (ClassLabelBasis* courselabel in course) {
        courselabel.backgroundColor = courselabel.tempBackground;
        courselabel.userInteractionEnabled = YES;
    }

}

-(IBAction)labelTapped:(id)sender
{
    UIGestureRecognizer * tapGesture = (UIGestureRecognizer *)sender;
    ClassLabelBasis*label = (ClassLabelBasis*)[self viewWithTag:tapGesture.view.tag];
    if (WhetherTapped) {    //是否進入修改課程頁面中
        if (label.changeColor) {    
            if (label.tag>=0)
                [self restorTheOriginalColor];
            else
                [TapAddCourse removeObject:label];
            if ([TapAddCourse count]==0) {
                [parent_ViewController alterButtonFunction:NO];
                [self removeAllcourselabel];
                [parent_ViewController displayModifyButton:NO];
            }
            label.backgroundColor = label.tempBackground;
            label.changeColor = NO;
        } else {
            if ([TapAddCourse count]==0) {
                if (label.tag>=0) {
                    [parent_ViewController DisplayUITextField:[NSArray arrayWithObjects:label.text, nil]];
                    [parent_ViewController alterButtonFunction:YES];
                }
                for (ClassLabelBasis* courselabel in course) {
                    if (courselabel.tag!=label.tag) {
                        courselabel.backgroundColor = [UIColor colorWithRed:211.0/255 green:211.0/255 blue:211.0/255 alpha:1];
                        courselabel.userInteractionEnabled = NO;
                    }
                }
                [parent_ViewController displayModifyButton:YES];
            }
            [TapAddCourse addObject:label];
            label.backgroundColor = [UIColor colorWithRed:187.0/255 green:255.0/255 blue:255.0/255 alpha:1];
            label.changeColor = YES;
        }
    }
    else {
        if (label.tag>=0&&[label.text isEqualToString:@"演算法"]) {
            [parent_ViewController showClassInfo:label];
        }
    }
    
}

-(void)drawColumnTextLabelNumber:(NSInteger)number Content:(NSArray *)content {

    for (int i=0;i<[content count] && i < [[ClassDataBase sharedData] FetchClassSessionTimes] && number<[[ClassDataBase sharedData]FetchWeekTimes];i++) {
        int sameClass=i;
        while (i+1<[content count]) {
            if ([[content objectAtIndex:i+1] isEqualToString:[content objectAtIndex:i]]&&![[content objectAtIndex:i]isEqualToString:@" "]) {
                    i++;
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
        label.tag = -((number*100+sameClass)*100+i-sameClass+1); //（第幾週數－１）＊１００００＋（第幾堂數－１）＊１００＋連堂數
        if (![[content objectAtIndex:i] isEqualToString:@" "]){
            label.backgroundColor = [color objectForKey:label.text];
            label.tag = -label.tag;
            [course addObject:label];
        }
        else if (i==4&&[[content objectAtIndex:i]isEqualToString:@" "])
            label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        else{
            label.backgroundColor = [UIColor clearColor];
        }
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.font = [UIFont fontWithName:@"Helvetica" size:15];
        label.textAlignment = UITextAlignmentCenter;
        label.layer.borderWidth = TextLabelborderWidth;
        label.tempBackground = label.backgroundColor;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [label addGestureRecognizer:tapGestureRecognizer];
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
