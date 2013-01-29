//
//  ClassDataBase.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

#import "ClassDataBase.h"

@implementation ClassDataBase
@synthesize ScheduleInfo;
@synthesize ScheduleViewDelegate;
@synthesize EditScheduleDelegate;
@synthesize ColorDic;
@synthesize professorName;
@synthesize classroomLocation;
@synthesize ScheduleTempInfo;
@synthesize token;
@synthesize courseCount;
@synthesize moodleFrom;
@synthesize professorTempName;
@synthesize classroomTempLocation;
@synthesize courseTempCount;
@synthesize moodleTempFrom;
@synthesize ColorTempDic;
@synthesize courseID;
@synthesize courseTempID;
@synthesize classID;
@synthesize classTempID;

static ClassDataBase *sharedData = nil;

+ (ClassDataBase *)sharedData {
    @synchronized(self) {
        if (sharedData == nil) {
            sharedData = [[super allocWithZone:NULL] init]; 
        }
    }
    return sharedData;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self) {
        WeekTimes = [aDecoder decodeIntForKey:WeekTimesKey];
        ClassSessionTimes = [aDecoder decodeIntForKey:ClassSessionTimesKey];
        showClassTimes = [aDecoder decodeBoolForKey:showClassTimesKey];
        ScheduleInfo = [[aDecoder decodeObjectForKey:ScheduleInfoKey] retain];
        WeekDays = [[aDecoder decodeObjectForKey:WeekDaysKey] retain];
        ColorDic = [[aDecoder decodeObjectForKey:ColorDicKey] retain];
        professorName = [[aDecoder decodeObjectForKey:professorNameKey] retain];
        classroomLocation = [[aDecoder decodeObjectForKey:classroomLocationKey] retain];
        courseCount = [[aDecoder decodeObjectForKey:courseCountKey] retain];
        moodleFrom = [[aDecoder decodeObjectForKey:moodleFromKey] retain];
        courseID = [[aDecoder decodeObjectForKey:courseIDKey] retain];
        classID = [[aDecoder decodeObjectForKey:classIDKey] retain];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:WeekTimes forKey:WeekTimesKey];
    [aCoder encodeInt:ClassSessionTimes forKey:ClassSessionTimesKey];
    [aCoder encodeBool:showClassTimes forKey:showClassTimesKey];
    [aCoder encodeObject:ScheduleInfo forKey:ScheduleInfoKey];
    [aCoder encodeObject:WeekDays forKey:WeekDaysKey];
    [aCoder encodeObject:ColorDic forKey:ColorDicKey];
    [aCoder encodeObject:professorName forKey:professorNameKey];
    [aCoder encodeObject:classroomLocation forKey:classroomLocationKey];
    [aCoder encodeObject:courseCount forKey:courseCountKey];
    [aCoder encodeObject:moodleFrom forKey:moodleFromKey];
    [aCoder encodeObject:courseID forKey:courseIDKey];
    [aCoder encodeObject:classID forKey:classIDKey];
}

-(NSDictionary *)VoidSchedule
{
    return [[NSDictionary alloc]initWithObjectsAndKeys:
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Monday",
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Tuesday",
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil] ,@"Wednesday",
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Thursday",
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Friday",
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Saturday",
            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Sunday",nil];
}

-(id)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
        if ([userPrefs objectForKey:ClassDataBaseKey]==nil) {
            WeekTimes = 7;
            ClassSessionTimes = 14;
            showClassTimes = false;
            ScheduleInfo = [[NSDictionary alloc]initWithObjectsAndKeys:
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"資料庫"],[NSString stringWithFormat:@"資料庫"],[NSString stringWithFormat:@"資料庫"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Monday",
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"演算法"],[NSString stringWithFormat:@"演算法"],[NSString stringWithFormat:@"演算法"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"程式語言"],[NSString stringWithFormat:@"程式語言"],[NSString stringWithFormat:@"程式語言"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Tuesday",
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"日文"],[NSString stringWithFormat:@"日文"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil] ,@"Wednesday",
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"性別平等與就業歧視"],[NSString stringWithFormat:@"性別平等與就業歧視"],[NSString stringWithFormat:@"現代藝術賞析"],[NSString stringWithFormat:@"現代藝術賞析"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Thursday",
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@"作業系統"],[NSString stringWithFormat:@"作業系統"],[NSString stringWithFormat:@"作業系統"],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Friday",
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Saturday",
                            [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "],[NSString stringWithFormat:@" "], nil],@"Sunday",nil];
            ScheduleTempInfo = (NSDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)ScheduleInfo, kCFPropertyListMutableContainers);
            WeekDays=[[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES], nil] retain];
            courseCount = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:3],[NSString stringWithFormat:@"資料庫"],[NSNumber numberWithInt:3],[NSString stringWithFormat:@"演算法"],[NSNumber numberWithInt:3],[NSString stringWithFormat:@"程式語言"],[NSNumber numberWithInt:3],[NSString stringWithFormat:@"日文"],[NSNumber numberWithInt:2],[NSString stringWithFormat:@"性別平等與就業歧視"],[NSNumber numberWithInt:2],[NSString stringWithFormat:@"現代藝術賞析"],[NSNumber numberWithInt:3],[NSString stringWithFormat:@"作業系統"], nil];
            moodleFrom = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:1],[NSString stringWithFormat:@"資料庫"],[NSNumber numberWithBool:1],[NSString stringWithFormat:@"演算法"],[NSNumber numberWithBool:1],[NSString stringWithFormat:@"程式語言"],[NSNumber numberWithBool:1],[NSString stringWithFormat:@"日文"],[NSNumber numberWithBool:1],[NSString stringWithFormat:@"性別平等與就業歧視"],[NSNumber numberWithBool:1],[NSString stringWithFormat:@"現代藝術賞析"],[NSNumber numberWithBool:1],[NSString stringWithFormat:@"作業系統"], nil];
            
            ColorDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[UIColor colorWithRed:193.0/255 green:255.0/255 blue:193.0/255 alpha:1],[NSString stringWithFormat:@"資料庫"],[UIColor colorWithRed:248.0/255 green:248.0/255 blue:255.0/255 alpha:1],[NSString stringWithFormat:@"演算法"],[UIColor colorWithRed:255.0/255 green:248.0/255 blue:220.0/255 alpha:1],[NSString stringWithFormat:@"程式語言"],[UIColor colorWithRed:245.0/255 green:255.0/255 blue:250.0/255 alpha:1],[NSString stringWithFormat:@"日文"],[UIColor colorWithRed:255.0/255 green:255.0/255 blue:224.0/255 alpha:1],[NSString stringWithFormat:@"性別平等與就業歧視"],[UIColor colorWithRed:255.0/255 green:246.0/255 blue:143.0/255 alpha:1],[NSString stringWithFormat:@"現代藝術賞析"],[UIColor colorWithRed:255.0/255 green:181.0/255 blue:197.0/255 alpha:0.5],[NSString stringWithFormat:@"作業系統"], nil];
            ColorTempDic = [[NSMutableDictionary dictionaryWithDictionary:ColorDic] retain];
            
            professorName = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"林清池"],[NSNumber numberWithInt:10103],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:503],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:10603],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:20202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30002],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:40103], nil];
            classroomLocation = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"CS301"],[NSNumber numberWithInt:10103],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:503],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:10603],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:20202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30002],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:40103], nil];
            professorTempName = [[NSMutableDictionary dictionaryWithDictionary:professorName] retain];
            classroomTempLocation = [[NSMutableDictionary dictionaryWithDictionary:classroomLocation] retain];
            moodleTempFrom = [[NSMutableDictionary dictionaryWithDictionary:moodleFrom] retain];
            courseTempCount = [[NSMutableDictionary dictionaryWithDictionary:courseCount] retain];
            courseID = [[NSMutableDictionary alloc] init];
            courseTempID = [[NSMutableDictionary dictionaryWithDictionary:courseID] retain];
            classID = [[NSMutableDictionary alloc] init];
            classTempID = [[NSMutableDictionary dictionaryWithDictionary:classID] retain];
        }
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *myEncodedObject = [defaults objectForKey: ClassDataBaseKey];
            ClassDataBase *obj = (ClassDataBase *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
            WeekTimes = obj->WeekTimes;
            ClassSessionTimes = obj->ClassSessionTimes;
            showClassTimes = obj->showClassTimes;
            ScheduleInfo = [[NSDictionary alloc] initWithDictionary:obj->ScheduleInfo];
            ScheduleTempInfo = (NSDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)ScheduleInfo, kCFPropertyListMutableContainers);
            ColorDic = [[NSMutableDictionary alloc] initWithDictionary:obj->ColorDic];
            courseCount = [[NSMutableDictionary alloc] initWithDictionary:obj->courseCount];
            moodleFrom = [[NSMutableDictionary alloc] initWithDictionary:obj->moodleFrom];
            professorName = [[NSMutableDictionary alloc] initWithDictionary:obj->professorName];
            classroomLocation = [[NSMutableDictionary alloc] initWithDictionary:obj->classroomLocation];
            WeekDays = [[NSMutableArray alloc] initWithArray:obj->WeekDays];
            professorTempName = [[NSMutableDictionary dictionaryWithDictionary:professorName] retain];
            classroomTempLocation = [[NSMutableDictionary dictionaryWithDictionary:classroomLocation] retain];
            moodleTempFrom = [[NSMutableDictionary dictionaryWithDictionary:moodleFrom] retain];
            courseTempCount = [[NSMutableDictionary dictionaryWithDictionary:courseCount] retain];
            ColorTempDic = [[NSMutableDictionary dictionaryWithDictionary:ColorDic] retain];
            courseID = obj->courseID;
            courseTempID = [[NSMutableDictionary dictionaryWithDictionary:courseID] retain];
            classID = obj->classID;
            classTempID = [[NSMutableDictionary dictionaryWithDictionary:classID] retain];
        }
        
    }
    return self;
}

-(BOOL)whetherHaveMoodleInfo:(NSString *)className
{
    
    return [[moodleTempFrom objectForKey:className] boolValue];
}

-(NSMutableDictionary*) FetchColorDic{
    return  ColorTempDic;
}

-(void)UpdataColorDic:(NSString*)Key ColorDic:(UIColor*)RGB
{
    if ([Key isEqualToString:[NSString string]])
        return;
    [ColorTempDic removeObjectForKey:Key];
    [ColorTempDic setValue:RGB forKey:Key];
}

-(NSString*) FetchProfessorName:(NSNumber*)Key{
    return  [professorTempName objectForKey:Key];
}

-(void)deleteProfessorName:(NSNumber*)Key
{
    if ([professorTempName objectForKey:Key]) {
        [professorTempName removeObjectForKey:Key];
    }
}

-(void)UpdataProfessorNameKey:(NSNumber*)Key ProfessorName:(NSString*)Name
{
    [self deleteProfessorName:Key];
    Key=[self mergeContinuousTag:Key checkDataType:professorTempName];
    [professorTempName setObject:Name forKey:Key];
}

-(NSString*) FetchClassroomLocation:(NSNumber*)Key{
    return  [classroomTempLocation objectForKey:Key];
}

-(void)deleteClassroomLocation:(NSNumber*)Key
{
    if ([classroomTempLocation objectForKey:Key]) {
        [classroomTempLocation removeObjectForKey:Key];
    }
}

-(void)UpdataClassroomLocationKey:(NSNumber*)Key Classroom:(NSString*)Location
{
    [self deleteClassroomLocation:Key];
    Key=[self mergeContinuousTag:Key checkDataType:classroomTempLocation];
    [classroomTempLocation setObject:Location forKey:Key];
}

#define upside 99
#define below 101
-(NSNumber*)mergeContinuousTag:(NSNumber*)Key checkDataType:(NSMutableDictionary*)dataType
{
    int Tag = [Key intValue];
    //NSLog(@"%@,%@,%@,",[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100-1],[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100],[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100+1]);
    if (([Key intValue]%10000)/100!=0) { //向上檢查是否連堂
        if ([[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100-1]
            ==[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100]) {
            int anotherTag = (Tag/100)*100-upside;
            while (![dataType objectForKey:[NSNumber numberWithInt:anotherTag]]) {
                anotherTag-=upside;
            }
            [dataType removeObjectForKey:[NSNumber numberWithInt:anotherTag]];
            Tag = anotherTag+Tag%100;
        }
    }
    if (([Key intValue]%10000)/100+[Key intValue]%100!=14) { //向下檢查是否連堂
        if ([[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100+1+([Key intValue]%100-1)]
            ==[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:([Key intValue]%10000)/100]) {
            int anotherTag = ([Key intValue]/100)*100+below+([Key intValue]%100-1)*100;
            while (![dataType objectForKey:[NSNumber numberWithInt:anotherTag]]) {
                anotherTag+=1;
            }
            [dataType removeObjectForKey:[NSNumber numberWithInt:anotherTag]];
            Tag +=anotherTag%100;
        }
    }
    return [NSNumber numberWithInt:Tag];
}

-(void)ClassAddCancel
{
    CFRelease(ScheduleTempInfo);
    ScheduleTempInfo = (NSDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)ScheduleInfo, kCFPropertyListMutableContainers);
    [professorTempName release];
    professorTempName = [[NSMutableDictionary dictionaryWithDictionary:professorName] retain];
    [classroomTempLocation release];
    classroomTempLocation = [[NSMutableDictionary dictionaryWithDictionary:classroomLocation] retain];
    [moodleTempFrom release];
    moodleTempFrom = [[NSMutableDictionary dictionaryWithDictionary:moodleFrom] retain];
    [courseTempCount release];
    courseTempCount = [[NSMutableDictionary dictionaryWithDictionary:courseCount] retain];
    [ColorTempDic release];
    ColorTempDic = [[NSMutableDictionary dictionaryWithDictionary:ColorDic] retain];
    [courseTempID release];
    courseTempID = [[NSMutableDictionary dictionaryWithDictionary:courseID] retain];
    [classTempID release];
    classTempID = [[NSMutableDictionary dictionaryWithDictionary:classID] retain];
}

-(void)ClassAddDecide
{
    CFRelease(ScheduleInfo);
    ScheduleInfo = (NSDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)ScheduleTempInfo, kCFPropertyListMutableContainers);
    [professorName release];
    professorName = [[NSMutableDictionary dictionaryWithDictionary:professorTempName] retain];
    [classroomLocation release];
    classroomLocation = [[NSMutableDictionary dictionaryWithDictionary:classroomTempLocation] retain];
    [moodleFrom release];
    moodleFrom = [[NSMutableDictionary dictionaryWithDictionary:moodleTempFrom] retain];
    [courseCount release];
    courseCount = [[NSMutableDictionary dictionaryWithDictionary:courseTempCount] retain];
    [ColorDic release];
    ColorDic = [[NSMutableDictionary dictionaryWithDictionary:ColorTempDic] retain];
    [courseID release];
    courseID = [[NSMutableDictionary dictionaryWithDictionary:courseTempID] retain];
    [classID release];
    classID = [[NSMutableDictionary dictionaryWithDictionary:classTempID] retain];
}

-(NSDictionary*) FetchScheduleInfo{
    return  ScheduleTempInfo;
}

-(NSMutableArray*)ScheduleInfoKeyToWeek:(NSNumber*)Key
{
    if ([Key intValue]/10000==Monday) {
        return [ScheduleTempInfo objectForKey:@"Monday"];
    }
    else if ([Key intValue]/10000==Tuesday) {
        return [ScheduleTempInfo objectForKey:@"Tuesday"];
    }
    else if ([Key intValue]/10000==Wednesday) {
        return [ScheduleTempInfo objectForKey:@"Wednesday"];
    }
    else if ([Key intValue]/10000==Thursday) {
        return [ScheduleTempInfo objectForKey:@"Thursday"];
    }
    else if ([Key intValue]/10000==Friday) {
        return [ScheduleTempInfo objectForKey:@"Friday"];
    }
    else if ([Key intValue]/10000==Saturday) {
        return [ScheduleTempInfo objectForKey:@"Saturday"];
    }
    else if ([Key intValue]/10000==Sunday) {
        return [ScheduleTempInfo objectForKey:@"Sunday"];
    }
    return nil;
}

-(void)deleteColorwhenCourseCountZero
{
    for (NSString* course in [ColorTempDic allKeys]) {
        if (![courseTempCount objectForKey:course]) {
            [ColorTempDic removeObjectForKey:course];
        }
    }
    
}

-(void)deleteMoodleFromWhenCourseCountZero
{
    for (NSString* Moodle in [moodleTempFrom allKeys]) {
        if (![courseTempCount objectForKey:Moodle]) {
            [moodleTempFrom removeObjectForKey:Moodle];
        }
    }
    
}

-(void)whenCourseCountZeroForDeleteCourse:(NSString *)oldCourse
{
    [courseTempCount removeObjectForKey:oldCourse];
}


-(void)courseCountReplaceForNewCourse:(NSString *)newCourse ForOldCourse:(NSString *)oldCourse
{
    if (![newCourse isEqualToString:@" "]) {
        if ([courseTempCount objectForKey:newCourse]) {
            NSLog(@"%@",[courseTempCount objectForKey:newCourse]);
            [courseTempCount setValue:[NSNumber numberWithInt:[[courseTempCount objectForKey:newCourse] intValue]+1] forKey:newCourse] ;
        }
        else
            [courseTempCount setValue:[NSNumber numberWithInt:1] forKey:newCourse] ;
    }
    if (![oldCourse isEqualToString:@" "]) {
        [courseTempCount setValue:[NSNumber numberWithInt:[[courseTempCount objectForKey:oldCourse] intValue]-1] forKey:oldCourse] ;
        if ([[courseTempCount objectForKey:oldCourse] intValue]==0)
            [self whenCourseCountZeroForDeleteCourse:oldCourse];
    }
}

-(void)moodleFromRecordForNewCourse:(NSString *)newCourse ForOldCourse:(NSString *)oldCourse
{
    if ([oldCourse isEqualToString:@" "]) {
        [moodleTempFrom setValue:[NSNumber numberWithBool:0] forKey:newCourse];
    }
    else
        [moodleTempFrom setValue:[moodleTempFrom objectForKey:oldCourse] forKey:newCourse];
}




-(void)UpdataColorFromFirstTap:(NSString *)newCourse ForOldCourse:(NSString*)oldCourse
{
    if ([oldCourse isEqualToString:@" "]) {
        [ColorTempDic setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:newCourse];
    }
    else
        [ColorTempDic setValue:[ColorTempDic objectForKey:oldCourse] forKey:newCourse];
}

-(void)UpdataScheduleInfo:(NSNumber*)Key ScheduleInfo:(NSString*)Name
{
    if([Key intValue] <0)
        Key = [NSNumber numberWithInt:-[Key intValue]];
    NSRange range =  NSMakeRange([Key intValue]%10000/100,[Key intValue]%100);
    for (int i=0; i < range.length; i++) {
        NSString* replaceCourse =[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:range.location+i];
        [self courseCountReplaceForNewCourse:Name ForOldCourse:replaceCourse];
        [[self ScheduleInfoKeyToWeek:Key] replaceObjectAtIndex:range.location+i  withObject:Name];
    }
    
}


-(int)FetchWeekTimes
{
    return WeekTimes;
}

-(int)FetchClassSessionTimes
{
    return ClassSessionTimes;
}

-(BOOL)FetchshowClassTimes
{
    return showClassTimes;
}


-(NSArray *)ShowClassTimes{
    if (showClassTimes) {
        return [NSArray arrayWithObjects:[NSString stringWithFormat:@"8:20   1    9:10"],[NSString stringWithFormat:@"9:20   2   10:10"],[NSString stringWithFormat:@"10:20  3   11:10"],[NSString stringWithFormat:@"11:15  4   12:05"],[NSString stringWithFormat:@"12:10  5   13:00"],[NSString stringWithFormat:@"13:10  6   14:00"],[NSString stringWithFormat:@"14:10  7   15:00"],[NSString stringWithFormat:@"15:10  8   16:00"],[NSString stringWithFormat:@"16:05  9   16:55"],[NSString stringWithFormat:@"17:30  10   18:20"],[NSString stringWithFormat:@"18:30  11   19:20"],[NSString stringWithFormat:@"19:25  12   20:15"],[NSString stringWithFormat:@"20:20  13   21:10"],[NSString stringWithFormat:@"21:15  14   22:05"], nil];
    } else {
        return [NSArray arrayWithObjects:[NSString stringWithFormat:@"1"],[NSString stringWithFormat:@"2"],[NSString stringWithFormat:@"3"],[NSString stringWithFormat:@"4"],[NSString stringWithFormat:@"5"],[NSString stringWithFormat:@"6"],[NSString stringWithFormat:@"7"],[NSString stringWithFormat:@"8"],[NSString stringWithFormat:@"9"],[NSString stringWithFormat:@"10"],[NSString stringWithFormat:@"11"],[NSString stringWithFormat:@"12"],[NSString stringWithFormat:@"13"],[NSString stringWithFormat:@"14"], nil];
    }
}


-(void)SetClassSessionTimes:(int)CST
{
    ClassSessionTimes = CST;
}

-(void)SetShowClassTimes:(BOOL) SCT
{
    showClassTimes = SCT;
}

-(void)SetWeekDays:(ColumnName)day
{
    if ([[WeekDays objectAtIndex:day] boolValue]) {
        WeekTimes--;
        [WeekDays replaceObjectAtIndex:day withObject:[NSNumber numberWithBool:NO]];
    } else {
        WeekTimes++;
        [WeekDays replaceObjectAtIndex:day withObject:[NSNumber numberWithBool:YES]];
        
    }
    [EditScheduleDelegate ReloadSetWeek];
}

-(BOOL)displayWeekDays:(ColumnName)day
{
    return [[WeekDays objectAtIndex:day] boolValue];
}

-(void)ClearAllCourses
{
    ScheduleInfo = [self VoidSchedule];
    ScheduleTempInfo = [self VoidSchedule];
    [ColorDic removeAllObjects];
    [professorName removeAllObjects];
    [professorTempName removeAllObjects];
    [classroomLocation removeAllObjects];
    [classroomTempLocation removeAllObjects];
    [courseCount removeAllObjects];
    [moodleFrom removeAllObjects];
    [moodleTempFrom removeAllObjects];
    [courseCount removeAllObjects];
    [ColorTempDic removeAllObjects];
    [courseID removeAllObjects];
    [courseTempID removeAllObjects];
    [classID removeAllObjects];
    [classTempID removeAllObjects];
}


-(NSMutableArray*)ScheduleInfoFromMoodleKeyToWeek:(NSString*)Key
{
    if ([Key isEqualToString:@"Mon"]) {
        return [ScheduleTempInfo objectForKey:@"Monday"];
    }
    else if ([Key isEqualToString:@"Tue"]) {
        return [ScheduleTempInfo objectForKey:@"Tuesday"];
    }
    else if ([Key isEqualToString:@"Wed"]) {
        return [ScheduleTempInfo objectForKey:@"Wednesday"];
    }
    else if ([Key isEqualToString:@"Thu"]) {
        return [ScheduleTempInfo objectForKey:@"Thursday"];
    }
    else if ([Key isEqualToString:@"Fri"]) {
        return [ScheduleTempInfo objectForKey:@"Friday"];
    }
    else if ([Key isEqualToString:@"Sat"]) {
        return [ScheduleTempInfo objectForKey:@"Saturday"];
    }
    else if ([Key isEqualToString:@"Sun"]) {
        return [ScheduleTempInfo objectForKey:@"Sunday"];
    }
    return nil;
}

-(int)ScheduleInfoFromMoodleKeyToNumber:(NSString*)Key
{
    if ([Key isEqualToString:@"Mon"]) {
        return Monday;
    }
    else if ([Key isEqualToString:@"Tue"]) {
        return Tuesday;
    }
    else if ([Key isEqualToString:@"Wed"]) {
        return Wednesday;
    }
    else if ([Key isEqualToString:@"Thu"]) {
        return Thursday;
    }
    else if ([Key isEqualToString:@"Fri"]) {
        return Friday;
    }
    else if ([Key isEqualToString:@"Sat"]) {
        return Saturday;
    }
    else if ([Key isEqualToString:@"Sun"]) {
        return Sunday;
    }
    return 0;
}

-(void)classPropertyAdd:(NSDictionary *)course
{
    [moodleTempFrom setValue:[NSNumber numberWithBool:1] forKey:[course objectForKey:moodleCourseNameKey]];
    [ColorTempDic setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:[course objectForKey:moodleCourseNameKey]];
    [courseTempID setValue:[course objectForKey:moodleCourseIdKey] forKey:[course objectForKey:moodleCourseNameKey]];
    [classTempID setValue:[course objectForKey:moodleCourseClassKey] forKey:[course objectForKey:moodleCourseNameKey]];

}

-(void)classPropertyDelete:(NSString *)course
{
    [ColorTempDic removeObjectForKey:course];
    [courseTempCount removeObjectForKey:course];
    [moodleTempFrom removeObjectForKey:course];
    [classTempID removeObjectForKey:course];
    [courseTempID removeObjectForKey:course];
}

-(void)updataScheduleFromMoodle:(NSDictionary *)dictionary
{
    for (NSDictionary * courseDic in [dictionary objectForKey:moodleListKey]) {
        
        NSMutableArray* daySched = [self ScheduleInfoFromMoodleKeyToWeek:[courseDic objectForKey:moodleCourseDayKey]];
        NSMutableArray* classroomArray = [NSMutableArray array];
        NSMutableArray* professorArray = [NSMutableArray array];
        
        for (NSDictionary* couses in [courseDic objectForKey:moodleCourseKey]) {
            NSString* replaceCourse=[daySched objectAtIndex:[[couses objectForKey:moodleCourseTimeKey] intValue]];
            [self courseCountReplaceForNewCourse:[couses objectForKey:moodleCourseNameKey] ForOldCourse:replaceCourse];
            [self classPropertyAdd:couses];
            [daySched replaceObjectAtIndex:[[couses objectForKey:moodleCourseTimeKey] intValue]-1 withObject:[couses objectForKey:moodleCourseNameKey]];
            
            [classroomArray addObject:[couses objectForKey:moodleCourseClassroomKey]];
            [professorArray addObject:[Moodle_API GetCourseInfo_AndUseToken:token courseID:[couses objectForKey:moodleCourseIdKey] classID:[couses objectForKey:moodleCourseClassKey]]];
        }
        
        for (int i=0,j=0;i<[daySched count] && i < [[ClassDataBase sharedData] FetchClassSessionTimes];i++) {
            
            while ([[daySched objectAtIndex:i]isEqualToString:@" "]&&i+1<[daySched count])
                i++;
            
            if (!(i+1<[daySched count])) {
                break;
            }
            
            int sameClass=i;
            while (i<[daySched count]&&[[daySched objectAtIndex:i+1] isEqualToString:[daySched objectAtIndex:i]])
                i++;
            
            NSNumber* tag = [NSNumber numberWithInt:([self ScheduleInfoFromMoodleKeyToNumber:[courseDic objectForKey:moodleCourseDayKey]]*100+sameClass)*100+i-sameClass+1];
            
            if (![[classroomTempLocation allKeys] containsObject:tag]) {
                [self UpdataClassroomLocationKey:tag Classroom:[classroomArray objectAtIndex:j]];
                [self UpdataProfessorNameKey:tag ProfessorName:[[professorArray objectAtIndex:j] objectForKey:moodleCourseTeacherKey]];
                for (;j+1<[classroomArray count]&&[[classroomArray objectAtIndex:j] isEqualToString:[classroomArray objectAtIndex:j+1]];)
                    if ([[classroomArray objectAtIndex:j] isEqualToString:[classroomArray objectAtIndex:j+1]]) {
                        j++;
                }
                if (j+1!=[classroomArray count]) {
                    j++;
                }
            }
        }

    }
}

-(void)deleteFromMoodle
{
    NSNumber* moodle = nil;
    NSArray* temp = [moodleTempFrom allKeys];
    for (int i = 0;i < [temp count];i++) {
        moodle = [moodleTempFrom objectForKey:[temp objectAtIndex:i]];
        if ([moodle boolValue]) {
            for (int day=0;day/10000<[[ScheduleTempInfo allValues] count];day+=10000) {
                NSMutableArray* week =[self ScheduleInfoKeyToWeek:[NSNumber numberWithInt:day]];
                for (int j = 0,sameCourse = 1; j<[week count] ;j++) {
                    NSString* courses = [week objectAtIndex:j];
                    if ([[temp objectAtIndex:i] isEqualToString:courses]) {
                        if (j+1<[week count]&&([[week objectAtIndex:j] isEqualToString:[week objectAtIndex:j+1]])) {
                            sameCourse++;
                        }
                        else{
                            NSNumber* Key=[NSNumber numberWithInt:day+(j-sameCourse+1)*100+sameCourse];
                            [professorTempName removeObjectForKey:Key];
                            [classroomTempLocation removeObjectForKey:Key];
                            sameCourse = 0;
                        }
                        [week replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@" "]];
                    }
                }
            }
            [self classPropertyDelete:[temp objectAtIndex:i]];
        }
    }
    
}

-(void)loginAccount:(NSString *)account Password:(NSString *)password ClearAllCourses:(BOOL)clear
{
    NSDictionary* info = [Moodle_API Login:account andPassword:password];
    //NSLog(@"%@",[info objectForKey:moodleLoginResultKey]);
    if([[info objectForKey:moodleLoginResultKey] intValue]==1){
        if (clear) {
            [self ClearAllCourses];
        }
        token = [info objectForKey:moodleLoginTokenKey];
        NSDictionary *schedule = [Moodle_API GetCourse_AndUseToken:token];
        [self deleteFromMoodle];
        [self updataScheduleFromMoodle:schedule];
        [self ClassAddDecide];
        [[ScheduleViewDelegate weekschedule] drawRect:CGRectZero];
    }
    else
    {
        UIAlertView *loadingAlertView = [[UIAlertView alloc]
                                         initWithTitle:nil message:@"帳號、密碼錯誤"
                                         delegate:self cancelButtonTitle:@"確定"
                                         otherButtonTitles:nil];
        [loadingAlertView show];
        [loadingAlertView release];
    }
}

-(NSString *)loginTokenWhenAccountFromUserDefault
{
    return [[Moodle_API Login:[[NSUserDefaults standardUserDefaults] objectForKey:accountKey] andPassword:[[NSUserDefaults standardUserDefaults] objectForKey:passwordKey]] objectForKey:moodleLoginTokenKey];
}

-(NSDictionary *)loginCourseToGetCourseidAndClassid:(NSString *)courseName
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[courseTempID objectForKey:courseName],courseIDKey,[classTempID objectForKey:courseName],classIDKey, nil];
}

@end
