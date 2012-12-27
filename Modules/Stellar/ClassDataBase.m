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
            WeekDays=[[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES], nil] retain];
            ColorDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[UIColor colorWithRed:193.0/255 green:255.0/255 blue:193.0/255 alpha:1],[NSString stringWithFormat:@"資料庫"],[UIColor colorWithRed:248.0/255 green:248.0/255 blue:255.0/255 alpha:1],[NSString stringWithFormat:@"演算法"],[UIColor colorWithRed:255.0/255 green:248.0/255 blue:220.0/255 alpha:1],[NSString stringWithFormat:@"程式語言"],[UIColor colorWithRed:245.0/255 green:255.0/255 blue:250.0/255 alpha:1],[NSString stringWithFormat:@"日文"],[UIColor colorWithRed:255.0/255 green:255.0/255 blue:224.0/255 alpha:1],[NSString stringWithFormat:@"性別平等與就業歧視"],[UIColor colorWithRed:255.0/255 green:246.0/255 blue:143.0/255 alpha:1],[NSString stringWithFormat:@"現代藝術賞析"],[UIColor colorWithRed:255.0/255 green:181.0/255 blue:197.0/255 alpha:1],[NSString stringWithFormat:@"作業系統"], nil];
            professorName = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"林清池"],[NSNumber numberWithInt:10103],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:503],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:10603],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:20202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30002],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:40103], nil];
            classroomLocation = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"CS301"],[NSNumber numberWithInt:10103],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:503],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:10603],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:20202],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:30002],[NSString stringWithFormat:@" "],[NSNumber numberWithInt:40103], nil];

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
            ColorDic = [[NSMutableDictionary alloc] initWithDictionary:obj->ColorDic];
            professorName = [[NSMutableDictionary alloc] initWithDictionary:obj->professorName];
            classroomLocation = [[NSMutableDictionary alloc] initWithDictionary:obj->classroomLocation];
            WeekDays = [[NSMutableArray alloc] initWithArray:obj->WeekDays];
            
        }
        
    }
    return self;
}


-(NSMutableDictionary*) FetchColorDic{
    return  ColorDic;
}

-(void)UpdataColorDic:(NSString*)Key ColorDic:(UIColor*)RGB
{
    [ColorDic removeObjectForKey:Key];
    [ColorDic setValue:RGB forKey:Key];
}

-(NSString*) FetchProfessorName:(NSNumber*)Key{
    return  [professorName objectForKey:Key];
}

-(void)deleteProfessorName:(NSNumber*)Key
{
    if ([professorName objectForKey:Key]) {
        [professorName removeObjectForKey:Key];
    }
}

-(void)UpdataProfessorNameKey:(NSNumber*)Key ProfessorName:(NSString*)Name
{
    [self deleteProfessorName:Key];
    [professorName setObject:Name forKey:Key];
}

-(NSString*) FetchClassroomLocation:(NSNumber*)Key{
    return  [classroomLocation objectForKey:Key];
}

-(void)deleteClassroomLocation:(NSNumber*)Key
{
    if ([classroomLocation objectForKey:Key]) {
        [classroomLocation removeObjectForKey:Key];
    }
}

-(void)UpdataClassroomLocationKey:(NSNumber*)Key ColorDic:(NSString*)Location
{
    [self deleteClassroomLocation:Key];
    [classroomLocation setObject:Location forKey:Key];
}

-(NSDictionary*) FetchScheduleInfo{
    return  ScheduleInfo;
}

-(NSMutableArray*)ScheduleInfoKeyToWeek:(NSNumber*)Key
{
    if ([Key intValue]/10000==Monday) {
        return [ScheduleInfo objectForKey:@"Monday"];
    }
    else if ([Key intValue]/10000==Tuesday) {
        return [ScheduleInfo objectForKey:@"Tuesday"];
    }
    else if ([Key intValue]/10000==Wednesday) {
        return [ScheduleInfo objectForKey:@"Wednesday"];
    }
    else if ([Key intValue]/10000==Thursday) {
        return [ScheduleInfo objectForKey:@"Thursday"];
    }
    else if ([Key intValue]/10000==Friday) {
        return [ScheduleInfo objectForKey:@"Friday"];
    }
    else if ([Key intValue]/10000==Saturday) {
        return [ScheduleInfo objectForKey:@"Saturday"];
    }
    else if ([Key intValue]/10000==Sunday) {
        return [ScheduleInfo objectForKey:@"Sunday"];
    }
    return nil;
}

-(void)UpdataScheduleInfo:(NSNumber*)Key ScheduleInfo:(NSString*)Name
{
    if([Key intValue] <0)
        Key = [NSNumber numberWithInt:-[Key intValue]];
    NSRange range =  NSMakeRange([Key intValue]%10000/100,[Key intValue]%100);
    BOOL iscontainsName= FALSE;
    for (NSString* week in [ScheduleInfo allKeys]) {
        if([[ScheduleInfo objectForKey:week] containsObject:[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:range.location]]){
            iscontainsName = true;
            break;
        }
    }
    if (!iscontainsName) {
        [ColorDic removeObjectForKey:[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:range.location]];
    }
    if(![Name isEqualToString:[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:range.location]]&&![ColorDic objectForKey:Name]){
        [ColorDic setValue:[ColorDic objectForKey:[[self ScheduleInfoKeyToWeek:Key] objectAtIndex:range.location]] forKey:Name];
    }
    else if (![ColorDic objectForKey:Name]) {
        [ColorDic setValue:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1] forKey:Name];
    }
    for (int i=0; i < range.length; i++) {
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

@end
