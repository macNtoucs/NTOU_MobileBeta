#import "NSDateFormatter+RelativeString.h"


@implementation NSDateFormatter (RelativeString)

#define SECONDS_PER_HOUR (60 * 60)

+ (NSString*)relativeDateStringFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate {
    NSMutableString *result = [NSMutableString string];
    NSDateComponents *dateDiff = [[NSCalendar currentCalendar] components:NSSecondCalendarUnit
                                                                 fromDate:fromDate
                                                                   toDate:toDate
                                                                  options:0];
    
    NSInteger minutes = ([dateDiff second] / 60);
    NSInteger hours = (minutes / 60);
    if ([dateDiff second] < 60) {
        [result appendString:@"less than 1 minute ago"];
    } else if ([dateDiff second] < SECONDS_PER_HOUR) {
        [result appendFormat:@"%d minute%@ ago",
         ([dateDiff second] / 60) + 1,
         ([dateDiff minute] < 2) ? @"" : @"s"];
    } else if ([dateDiff second] < (SECONDS_PER_HOUR * 6)) {
        [result appendFormat:@"%d hour%@ ago",
         hours,
         (hours < 2) ? @"" : @"s"];
    } else {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDoesRelativeDateFormatting:YES];
        [formatter setDefaultDate:toDate];
        
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [result appendString:[formatter stringFromDate:fromDate]];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateStyle:NSDateFormatterNoStyle];
        [result appendFormat:@" at %@", [formatter stringFromDate:fromDate]];
    }
    
    return result;
}

@end
