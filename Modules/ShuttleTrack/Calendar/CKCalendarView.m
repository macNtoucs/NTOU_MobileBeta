//
// Copyright (c) 2012 Jason Kozemczak
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//


#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "CKCalendarView.h"
#import "LayoutStyle.h"

@class CALayer;
@class CAGradientLayer;

@interface GradientView : UIView

@property(nonatomic, strong, readonly) CAGradientLayer *gradientLayer;
- (void)setColors:(NSArray *)colors;

@end

@implementation GradientView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors {
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = cgColors;
}

@end


@interface DateButton : UIButton

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, retain) UILabel* label;
@property (nonatomic) bool expired;

@end

@implementation DateButton

@synthesize date = _date;
@synthesize label = _label;
@synthesize expired;
- (void)setDate:(NSDate *)aDate {
    _date = aDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"d";
    [self setTitle:[dateFormatter stringFromDate:_date] forState:UIControlStateNormal];
    [_date retain];
}

@end

@interface ContainerView : UIView

@property(nonatomic, strong) NSMutableArray *dateButtons;

@end

@implementation ContainerView

@synthesize dateButtons;

@end

@interface CKCalendarView ()

@property(nonatomic, strong) UIView *highlight;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *prevButton;
@property(nonatomic, strong) UIButton *nextButton;
@property(nonatomic, strong) ContainerView *calendarContainer;
@property(nonatomic, strong) GradientView *daysHeader;
@property(nonatomic, strong) NSArray *dayOfWeekLabels;

@property (nonatomic) startDay calendarStartDay;
@property (nonatomic, strong) NSDate *monthShowing;
@property (nonatomic, strong) NSCalendar *calendar;
@property(nonatomic, assign) CGFloat cellWidth;
@property(nonatomic , retain) NSDate* tody;

@end


@implementation CKCalendarView

@synthesize highlight = _highlight;
@synthesize titleLabel = _titleLabel;
@synthesize prevButton = _prevButton;
@synthesize nextButton = _nextButton;
@synthesize calendarContainer = _calendarContainer;
@synthesize daysHeader = _daysHeader;
@synthesize dayOfWeekLabels = _dayOfWeekLabels;

@synthesize monthShowing = _monthShowing;
@synthesize calendar = _calendar;

@synthesize selectedDate = _selectedDate;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;

@synthesize selectedDateTextColor = _selectedDateTextColor;
@synthesize selectedDateBackgroundColor = _selectedDateBackgroundColor;
@synthesize expiredDateTextColor = _expiredDateTextColor;
@synthesize expiredDateTextColorBGColor = _expiredDateTextColorBGColor;

@synthesize currentDateTextColor = _currentDateTextColor;
@synthesize currentDateBackgroundColor = _currentDateBackgroundColor;
@synthesize cellWidth = _cellWidth;
@synthesize tody;
@synthesize calendarStartDay;

- (id)init {
  
    return [self initWithStartDay:startSunday];
}

- (id)initWithStartDay:(startDay)firstDay {
    self.calendarStartDay = firstDay;
    [self.monthShowing retain];
    return [self initWithFrame:CGRectMake(0, 0, 320, 320)];
}

- (id)initWithStartDay:(startDay)firstDay frame:(CGRect)frame {
    self.calendarStartDay = firstDay;
    [self.monthShowing retain];
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self.calendar setLocale:[NSLocale currentLocale]]; 
        [self.calendar setFirstWeekday:self.calendarStartDay];
        self.cellWidth = DEFAULT_CELL_WIDTH;
        
//        self.layer.cornerRadius = 6.0f;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 2.0f;
        self.layer.shadowOpacity = 0.4f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;

        UIView *highlight = [[UIView alloc] initWithFrame:CGRectZero];
        highlight.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        highlight.layer.cornerRadius = 6.0f;
        [self addSubview:highlight];
        self.highlight = highlight;

        // SET UP THE HEADER
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;

        UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [prevButton setImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
        prevButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [prevButton addTarget:self action:@selector(moveCalendarToPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevButton];
        self.prevButton = prevButton;

        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [nextButton addTarget:self action:@selector(moveCalendarToNextMonth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        self.nextButton = nextButton;

        // THE CALENDAR ITSELF
        ContainerView *calendarContainer = [[ContainerView alloc] initWithFrame:CGRectZero];
        calendarContainer.layer.borderWidth = 1.0f;
        calendarContainer.layer.borderColor = [UIColor blackColor].CGColor;
        calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        calendarContainer.layer.cornerRadius = 4.0f;
        calendarContainer.clipsToBounds = YES;
        [self addSubview:calendarContainer];
        self.calendarContainer = calendarContainer;

        GradientView *daysHeader = [[GradientView alloc] initWithFrame:CGRectZero];
        daysHeader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.calendarContainer addSubview:daysHeader];
        self.daysHeader = daysHeader;

        NSMutableArray *labels = [NSMutableArray array];
        for (NSString *day in [self getDaysOfTheWeek]) {
            UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            dayOfWeekLabel.text = NSLocalizedString([day uppercaseString],nil);
            dayOfWeekLabel.textAlignment = UITextAlignmentCenter;
            dayOfWeekLabel.backgroundColor = [UIColor clearColor];
            dayOfWeekLabel.shadowColor = [UIColor whiteColor];
            dayOfWeekLabel.shadowOffset = CGSizeMake(0, 1);
            [labels addObject:dayOfWeekLabel];
            [self.calendarContainer addSubview:dayOfWeekLabel];
        }
        self.dayOfWeekLabels = labels;

        // at most we'll need 42 buttons, so let's just bite the bullet and make them now...
        NSMutableArray *dateButtons = [NSMutableArray array];
        
#pragma unused(dateButtons)
        
        dateButtons = [NSMutableArray array];
        for (int i = 0; i < 43; i++) {
            DateButton *dateButton = [DateButton buttonWithType:UIButtonTypeCustom];
            [dateButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
           
            dateButton.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            dateButton.titleLabel.textAlignment = UITextAlignmentCenter;
            // set date label.
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            dateLabel.textAlignment = UITextAlignmentCenter;
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            dateLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
            
            [dateButton addSubview:dateLabel];
            dateButton.label = dateLabel;
            
            // add dateButton to Array
            [dateButtons addObject:dateButton];
        }
        self.calendarContainer.dateButtons = dateButtons;
        

        // initialize the thing
        self.monthShowing = [[NSDate alloc]init];
        self.monthShowing = [NSDate date];
        [self.monthShowing retain];
        [self setDefaultStyle];
    }

    [self layoutSubviews]; // TODO: this is a hack to get the first month to show properly
    return self;
}

-(bool)checkTheDateIsExpired:(NSDate*) date{
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate *selectedDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date] ;
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents* todayComponents = [self.calendar components:unitFlags fromDate:tody];
    
    NSDateComponents* otherComponents = [self.calendar components:unitFlags fromDate:selectedDate];
    if (  otherComponents.year<todayComponents.year ||
          ((otherComponents.year == todayComponents.year) && otherComponents.month<todayComponents.month) ||
          ((otherComponents.year == todayComponents.year)&& (otherComponents.month == todayComponents.month) && otherComponents.day<todayComponents.day)
        ) return true;
    else return  false;
}


- (void)layoutSubviews {
    [super layoutSubviews];
  
    CGFloat containerWidth = self.bounds.size.width - (CALENDAR_MARGIN * 2);
    self.cellWidth = (containerWidth / 7.0) - CELL_BORDER_WIDTH;
    CGFloat containerHeight = ([self numberOfWeeksInMonthContainingDate:[NSDate date]] * (self.cellWidth + CELL_BORDER_WIDTH) + DAYS_HEADER_HEIGHT);


    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight + CALENDAR_MARGIN + TOP_HEIGHT;
    self.frame = newFrame;

    self.highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);

    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, TOP_HEIGHT);
    self.prevButton.frame = CGRectMake(BUTTON_MARGIN, BUTTON_MARGIN, 48, 38);
    self.nextButton.frame = CGRectMake(self.bounds.size.width - 48 - BUTTON_MARGIN, BUTTON_MARGIN, 48, 38);

    self.calendarContainer.frame = CGRectMake(CALENDAR_MARGIN, CGRectGetMaxY(self.titleLabel.frame), containerWidth, containerHeight);
    self.daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, DAYS_HEADER_HEIGHT);

    CGRect lastDayFrame = CGRectZero;
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + CELL_BORDER_WIDTH, lastDayFrame.origin.y, self.cellWidth, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }

    for (DateButton *dateButton in self.calendarContainer.dateButtons) {
        [dateButton removeFromSuperview];
    }

    NSDate *date = [self firstDayOfMonthContainingDate:self.monthShowing];
    uint dateButtonPosition = 0;
    while ([self dateIsInMonthShowing:date]) {
        DateButton *dateButton = [self.calendarContainer.dateButtons objectAtIndex:dateButtonPosition];

        // set Button for date;
        UIColor* textColor = [UIColor blackColor];
        [self.dataSource loadDate:date];
        dateButton.date = date;
        
        //過期日期 不加入點擊事件
        if (dateButton!=nil&&[self checkTheDateIsExpired: dateButton.date])
            dateButton.expired=true;
        else dateButton.expired=false;
        if (!dateButton.expired)
            [dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([dateButton.date isEqualToDate:self.selectedDate] && !dateButton.expired) {
            textColor = self.selectedDateTextColor;
            dateButton.backgroundColor = self.selectedDateBackgroundColor;
        } else if ([self dateIsToday:dateButton.date] ) {
            NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
            
            NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
            NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
            NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
            NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
            tody = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date] ;
            textColor = self.currentDateTextColor;
            dateButton.backgroundColor = self.currentDateBackgroundColor;
        }else if (dateButton.expired){
            textColor = self.expiredDateTextColor;
            dateButton.backgroundColor = self.expiredDateTextColorBGColor;
        }else {
            textColor = [self dateTextColor];
            dateButton.backgroundColor = [self dateBackgroundColor];
        }
       
        // set lunar text.
        if (self.dataSource.dayType & SOLARTERM)
            dateButton.label.text = NSLocalizedString([self.dataSource SolarTermTitle], nil);
        else
            dateButton.label.text = NSLocalizedString([self.dataSource DayLunar],nil);
        
        // set Button & label style
        dateButton.label.textColor = textColor;
        [dateButton setTitleColor:textColor forState:UIControlStateNormal];

        dateButton.frame = [self calculateDayCellFrame:date];
        
        // calculate layout of datebutton
        int width = self.cellWidth;
        int height = self.cellWidth;
        int top = height / 4;
        dateButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, top, 0);
        dateButton.label.frame = CGRectMake(0, height - top - CELL_OVERLAP, width, top + CELL_OVERLAP);
        
        [self.calendarContainer addSubview:dateButton];
        
        date = [self nextDay:date];
        dateButtonPosition++;
    }
}

- (void)setMonthShowing:(NSDate *)aMonthShowing {
    _monthShowing = aMonthShowing;
    [_monthShowing retain];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM月 YYYY年";
    self.titleLabel.text = [dateFormatter stringFromDate:aMonthShowing];
    [self setNeedsLayout];
}

- (void)setDefaultStyle {
    self.backgroundColor = UIColorFromRGB(0x393B40);

    [self setTitleColor:[UIColor whiteColor]];
    [self setTitleFont:[UIFont boldSystemFontOfSize:17.0]];

    [self setDayOfWeekFont:[UIFont boldSystemFontOfSize:12.0]];
    [self setDayOfWeekTextColor:UIColorFromRGB(0x999999)];
    [self setDayOfWeekBottomColor:UIColorFromRGB(0xCCCFD5) topColor:[UIColor whiteColor]];

    [self setDateFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setDateTextColor:UIColorFromRGB(0x393B40)];
    [self setDateBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    [self setDateBorderColor:UIColorFromRGB(0xDAE1E6)];

    [self setSelectedDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setSelectedDateBackgroundColor:UIColorFromRGB(0x88B6DB)];

    [self setCurrentDateTextColor:[UIColor whiteColor]];
    [self setCurrentDateBackgroundColor:UIColorFromRGB(0x000000)];
    
    [self setExpiredDateTextColor:[UIColor whiteColor]];
    [self setExpiredDateTextColorBGColor:UIColorFromRGB(0xa9a9a9)];
}

- (CGRect)calculateDayCellFrame:(NSDate *)date {
    int row = [self weekNumberInMonthForDate:date] - 1;
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - self.calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (self.cellWidth + CELL_BORDER_WIDTH), (row * (self.cellWidth + CELL_BORDER_WIDTH)) + CGRectGetMaxY(self.daysHeader.frame) + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
}

- (void)moveCalendarToNextMonth {
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    [self.monthShowing retain];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
}

- (void)moveCalendarToPreviousMonth {
    [self.monthShowing retain];
    self.monthShowing = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
}

- (void)dateButtonPressed:(id)sender {
    DateButton *dateButton = sender;
    if (dateButton.expired) return;
    self.selectedDate = dateButton.date;
    [self.delegate didSelectDate:self.selectedDate];
    [self setNeedsLayout];
}

#pragma mark - Theming getters/setters

- (void)setTitleFont:(UIFont *)font {
    self.titleLabel.font = font;
}
- (UIFont *)titleFont {
    return self.titleLabel.font;
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}
- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}

- (void)setButtonColor:(UIColor *)color {
    [self.prevButton setImage:[CKCalendarView imageNamed:@"left_arrow.png" withColor:color] forState:UIControlStateNormal];
    [self.nextButton setImage:[CKCalendarView imageNamed:@"right_arrow.png" withColor:color] forState:UIControlStateNormal];
}

- (void)setInnerBorderColor:(UIColor *)color {
    self.calendarContainer.layer.borderColor = color.CGColor;
}

- (void)setDayOfWeekFont:(UIFont *)font {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.font = font;
    }
}
- (UIFont *)dayOfWeekFont {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).font : nil;
}

- (void)setDayOfWeekTextColor:(UIColor *)color {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.textColor = color;
    }
}
- (UIColor *)dayOfWeekTextColor {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).textColor : nil;
}

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor {
    [self.daysHeader setColors:[NSArray arrayWithObjects:topColor, bottomColor, nil]];
}

- (void)setDateFont:(UIFont *)font {
    for (DateButton *dateButton in self.calendarContainer.dateButtons) {
        dateButton.titleLabel.font = font;
    }
}
- (UIFont *)dateFont {
    return (self.calendarContainer.dateButtons.count > 0) ? ((DateButton *)[self.calendarContainer.dateButtons lastObject]).titleLabel.font : nil;
}

- (void)setDateTextColor:(UIColor *)color {
    for (DateButton *dateButton in self.calendarContainer.dateButtons) {
        [dateButton setTitleColor:color forState:UIControlStateNormal];
    }
}
- (UIColor *)dateTextColor {
    if (self.calendarContainer.dateButtons.count > 0) {
        if (self.dataSource.dayType & SOLARTERM)
            return [UIColor greenColor];
        else if (self.dataSource.dayType & WEEKEND) 
            return [UIColor redColor];
        else
            return [((DateButton *)[self.calendarContainer.dateButtons lastObject]) titleColorForState:UIControlStateNormal];
    } else {
        return nil;
    }
}

- (void)setDateBackgroundColor:(UIColor *)color {
    for (DateButton *dateButton in self.calendarContainer.dateButtons) {
        dateButton.backgroundColor = color;
    }
}
- (UIColor *)dateBackgroundColor {
    return (self.calendarContainer.dateButtons.count > 0) ? ((DateButton *)[self.calendarContainer.dateButtons lastObject]).backgroundColor : nil;
}

- (void)setDateBorderColor:(UIColor *)color {
    self.calendarContainer.backgroundColor = color;
}
- (UIColor *)dateBorderColor {
    return self.calendarContainer.backgroundColor;
}

#pragma mark - Calendar helpers

- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}

- (NSArray *)getDaysOfTheWeek {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // adjust array depending on which weekday should be first
    NSArray *weekdays = [dateFormatter shortWeekdaySymbols];
    NSUInteger firstWeekdayIndex = [self.calendar firstWeekday] -1;
    if (firstWeekdayIndex > 0)
    {
        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7-firstWeekdayIndex)]
                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0,firstWeekdayIndex)]];
    }
    return weekdays;
}

- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}

- (BOOL)dateIsToday:(NSDate *)date {
    NSDateComponents *otherDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}

- (int)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    NSLog(@"%d",[self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length);
    
    return [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

- (BOOL)dateIsInMonthShowing:(NSDate *)date {
    NSDateComponents *comps1 = [self.calendar components:(NSMonthCalendarUnit) fromDate:self.monthShowing];
    NSDateComponents *comps2 = [self.calendar components:(NSMonthCalendarUnit) fromDate:date];
    return comps1.month == comps2.month;
}

- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];

    UIGraphicsBeginImageContext(img.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];

    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);

    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);

    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return coloredImg;
}

@end
