//
//  Kuo_Data.h
//  MIT Mobile
//
//  Created by mini server on 12/11/16.
//
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
@interface Kuo_Data : NSObject{
    NSDictionary * ScheduleInfo;
    NSMutableArray* Stop;
    NSArray* Index;
    NSMutableArray* IndexBase;
    NSMutableArray* Route;
    NSMutableArray* NextPageUrl;
}

@property (nonatomic,retain) NSDictionary *ScheduleInfo;
@property (nonatomic,retain) NSMutableArray* Stop;
@property (nonatomic,retain) NSArray* Index;
@property (nonatomic,retain) NSMutableArray* IndexBase;
@property (nonatomic,retain) NSMutableArray* Route;
@property (nonatomic,retain) NSMutableArray* NextPageUrl;

+ (Kuo_Data *)sharedData;

@end
