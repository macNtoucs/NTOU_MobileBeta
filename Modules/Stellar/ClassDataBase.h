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


#define WeekTimesKey @"WeekTimesKey"
#define ClassSessionTimesKey @"ClassSessionTimesKey"
#define showClassTimesKey @"showClassTimesKey"
#define ScheduleInfoKey @"ScheduleInfoKey"
#define WeekDaysKey @"WeekDaysKey"
#define ClassDataBaseKey @"classDataBaseKey"
#define ColorDicKey @"ColorDicKey"
#define professorNameKey @"professorNameKey"
#define classroomLocationKey @"classroomLocationKey"
#define courseCountKey @"courseCountKey"
#define moodleFromKey @"moodleFromKey"

#import <Foundation/Foundation.h>
#import "DefinePixel.h"
#import "Moodle_API.h"
typedef enum {Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday } ColumnName;
@interface ClassDataBase : NSObject<NSCoding>{
    int WeekTimes;
    int ClassSessionTimes;
    bool showClassTimes;
    NSDictionary * ScheduleInfo; //key是星期幾 value是mutable array記錄課表
    NSDictionary * ScheduleTempInfo;
    id ScheduleViewDelegate;
    id EditScheduleDelegate;
    NSMutableArray* WeekDays;
    NSMutableDictionary* ColorDic;
    NSMutableDictionary* professorName;
    NSMutableDictionary* professorTempName;
    NSMutableDictionary* classroomLocation;
    NSMutableDictionary* classroomTempLocation;
    NSMutableDictionary* courseCount;
    NSMutableDictionary* courseTempCount;
    NSMutableDictionary* moodleFrom;
    NSMutableDictionary* moodleTempFrom;
    NSString * token;
}

@property (nonatomic,retain) NSDictionary *ScheduleInfo;
@property (nonatomic,retain) NSDictionary *courseCount;
@property (nonatomic,retain) NSDictionary *moodleFrom;
@property (nonatomic,retain) NSDictionary *ScheduleTempInfo;
@property (nonatomic,retain) NSMutableDictionary *ColorDic;
@property (nonatomic,retain) NSMutableDictionary* professorName;
@property (nonatomic,retain) NSMutableDictionary* classroomLocation;
@property (nonatomic,retain) NSMutableDictionary* professorTempName;
@property (nonatomic,retain) NSMutableDictionary* classroomTempLocation;
@property (nonatomic,retain) NSMutableDictionary* courseTempCount;
@property (nonatomic,retain) NSMutableDictionary* moodleTempFrom;
@property (nonatomic,retain) NSString * token;
@property (nonatomic,assign) id ScheduleViewDelegate;
@property (nonatomic,assign) id EditScheduleDelegate;

+ (ClassDataBase *)sharedData;
-(NSMutableDictionary*) FetchColorDic;
-(void)UpdataColorDic:(NSString*)Key ColorDic:(UIColor*)RGB;
-(int)FetchWeekTimes;
-(int)FetchClassSessionTimes;
-(void)SetClassSessionTimes:(int)CST;
-(void)SetShowClassTimes:(BOOL) SCT;

-(NSDictionary*) FetchScheduleInfo;
-(void)UpdataScheduleInfo:(NSNumber*)Key ScheduleInfo:(NSString*)Name;

-(NSArray *)ShowClassTimes;
-(BOOL)FetchshowClassTimes;

-(void)SetWeekDays:(ColumnName)day;
-(BOOL)displayWeekDays:(ColumnName)day;

-(NSString*) FetchProfessorName:(NSNumber*)Key;
-(void)deleteProfessorName:(NSNumber*)Key;
-(void)UpdataProfessorNameKey:(NSNumber*)Key ProfessorName:(NSString*)Name;

-(NSString*) FetchClassroomLocation:(NSNumber*)Key;
-(void)deleteClassroomLocation:(NSNumber*)Key;
-(void)UpdataClassroomLocationKey:(NSNumber*)Key Classroom:(NSString*)Location;

-(void)ClassAddCancel;
-(void)ClassAddDecide;

-(void)ClearAllCourses;
-(void)loginAccount:(NSString *)account Password:(NSString *)password;

@end
