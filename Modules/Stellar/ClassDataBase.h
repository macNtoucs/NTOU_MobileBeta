//
//  ClassDataBase.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

@protocol ClassDataBaseDelegate <NSObject>
@required
-(void)ChangeDisplayView;
@end

@protocol EditDataBaseDelegate <NSObject>
@required
-(void)ReloadSetWeek;
@end

#import <Foundation/Foundation.h>
#import "DefinePixel.h"
typedef enum {Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday } ColumnName;
@interface ClassDataBase : NSObject{
    int WeekTimes;
    int ClassSessionTimes;
    bool showClassTimes;
    NSDictionary * ScheduleInfo; //key是星期幾 value是mutable array記錄課表
    id ScheduleViewDelegate;
    id EditScheduleDelegate;
    NSMutableArray* WeekDays;
}

@property (nonatomic,retain) NSDictionary *ScheduleInfo;
@property (nonatomic,assign) id ScheduleViewDelegate;
@property (nonatomic,assign) id EditScheduleDelegate;

+ (ClassDataBase *)sharedData;
-(int)FetchWeekTimes;
-(int)FetchClassSessionTimes;
-(void)SetClassSessionTimes:(int)CST;
-(void)SetShowClassTimes:(BOOL) SCT;
-(NSDictionary*) FetchScheduleInfo;
-(NSArray *)ShowClassTimes;
-(BOOL)FetchshowClassTimes;
-(void)SetWeekDays:(ColumnName)day;
-(BOOL)displayWeekDays:(ColumnName)day;
@end
