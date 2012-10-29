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
}

+ (ClassDataBase *)sharedData;
-(int)FetchWeekTimes;
-(int)FetchClassSessionTimes;
@end
