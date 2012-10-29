//
//  ClassDataBase.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

#import <Foundation/Foundation.h>
#import "DefinePixel.h"
@interface ClassDataBase : NSObject{
    int WeekTimes;
    int ClassSessionTimes;
    bool showClassTimes;
    NSDictionary * ScheduleInfo; //key是星期幾 value是mutable array記錄課表
}

@property (nonatomic,retain) NSDictionary *ScheduleInfo;

+ (ClassDataBase *)sharedData;
-(int)FetchWeekTimes;
-(int)FetchClassSessionTimes;
-(NSDictionary*) FetchScheduleInfo;
-(bool)ShowClassTimes;
@end
