//
//  ClassDataBase.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/27.
//
//

#import "ClassDataBase.h"

@implementation ClassDataBase

static ClassDataBase *sharedEmergencyData = nil;

+ (ClassDataBase *)sharedData {
    @synchronized(self) {
        if (sharedEmergencyData == nil) {
            sharedEmergencyData = [[super allocWithZone:NULL] init]; // assignment not done here
        }
    }
    return sharedEmergencyData;
}

-(id)init
{
    self = [super init];
    if (self) {
        WeekTimes = 6;
        ClassSessionTimes = 14;
    }
    return self;
}

-(int)FetchWeekTimes
{
    return WeekTimes;
}

-(int)FetchClassSessionTimes
{
    return ClassSessionTimes;
}

@end
