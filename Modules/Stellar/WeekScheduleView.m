//
//  WeekScheduleView.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/25.
//
//

#import "WeekScheduleView.h"
#import "DefinePixel.h"
@implementation WeekScheduleView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
   
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)drawColumnTextLabelNumber:(NSInteger)number Content:(NSArray *)content {
    for (int i=0;i<[content count] && i < ClassSessionTimes && number<=WeekTimes ;i++) {
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
        if (number)
            labelFrame = CGRectMake( LeftBaseline+(number-1)*(UpperViewWidth-TextLabelborderWidth), UpperBaseline+(LeftViewHeight-TextLabelborderWidth)*sameClass, UpperViewWidth, LeftViewHeight+(LeftViewHeight-TextLabelborderWidth)*(i-sameClass));
        else
            labelFrame = CGRectMake( 0,(LeftViewHeight-TextLabelborderWidth)*i, LeftBaseline, LeftViewHeight );
        UILabel* label = [[[UILabel alloc] initWithFrame: labelFrame] autorelease];
        label.text = [content objectAtIndex:i];
        label.backgroundColor = [UIColor colorWithRed:(arc4random()%155+100)*1.0/255 green:(arc4random()%155+100)*1.0/255 blue:(arc4random()%155+100)*1.0/255 alpha:1];
        NSLog(@"%@",label.backgroundColor);
        if (!number)
            label.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        else if ([[content objectAtIndex:i] isEqualToString:@" "]){
            label.backgroundColor = [UIColor clearColor];
        }
        if (i==4&&[[content objectAtIndex:i]isEqualToString:@" "])
            label.backgroundColor = [UIColor colorWithRed:105.0/255 green:105.0/255 blue:105.0/255 alpha:1];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.font = [UIFont fontWithName:@"AppleGothic" size:15];

        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderWidth = TextLabelborderWidth;

        label.numberOfLines=0;
        label.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview: label];
    }
}



- (void)drawRect:(CGRect)rect
{
    //[self drawRowWeekNameTextLabel];
    //[self drawColumnTextLabelNumber:Session Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1"],[NSString stringWithFormat:@"2"],[NSString stringWithFormat:@"3"],[NSString stringWithFormat:@"4"],[NSString stringWithFormat:@"5"],[NSString stringWithFormat:@"6"],[NSString stringWithFormat:@"7"],[NSString stringWithFormat:@"8"],[NSString stringWithFormat:@"9"],[NSString stringWithFormat:@"10"],[NSString stringWithFormat:@"11"],[NSString stringWithFormat:@"12"],[NSString stringWithFormat:@"13"],[NSString stringWithFormat:@"14"], nil]];
    [self drawColumnTextLabelNumber:Monday Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"資料庫"],[NSString stringWithFormat:@"資料庫"],[NSString stringWithFormat:@"資料庫"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil]];
    [self drawColumnTextLabelNumber:Tuesday Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"圖論演算法"],[NSString stringWithFormat:@"圖論演算法"],[NSString stringWithFormat:@"圖論演算法"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"程式語言"],[NSString stringWithFormat:@"程式語言"],[NSString stringWithFormat:@"程式語言"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil]];
    [self drawColumnTextLabelNumber:Wednesday Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"日文"],[NSString stringWithFormat:@"日文"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil]];
    [self drawColumnTextLabelNumber:Thursday Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@"性別平等與就業歧視"],[NSString stringWithFormat:@"性別平等與就業歧視"],[NSString stringWithFormat:@"現代藝術賞析"],[NSString stringWithFormat:@"現代藝術賞析"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil]];
    [self drawColumnTextLabelNumber:Friday Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"作業系統"],[NSString stringWithFormat:@"作業系統"],[NSString stringWithFormat:@"作業系統"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil]];
    [self drawColumnTextLabelNumber:Saturday Content:[NSArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil]];
    
    [super drawRect:rect];
}


@end
