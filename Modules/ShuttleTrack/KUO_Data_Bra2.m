//
//  KUO_Data_Bra2.m
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import "KUO_Data_Bra2.h"

@implementation KUO_Data_Bra2
static KUO_Data_Bra2 *sharedData = nil;

+ (KUO_Data_Bra2 *)sharedData {
    @synchronized(self) {
        if (sharedData == nil) {
            sharedData = [[super allocWithZone:NULL] init];
        }
    }
    return sharedData;
}


-(id)init
{
    self = [super init];
    if (self) {
        BOOL success;
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
        NSString *filePath = [paths objectAtIndex:0];
        filePath = [filePath stringByAppendingString:@"/K_data.plist"];
        success = [fileManager fileExistsAtPath:filePath];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/K_data.plist"];
        if (![fileManager contentsEqualAtPath:filePath andPath:path]) {
            [fileManager removeItemAtPath:filePath error:&error];
            success = NO;
        }
        if (!success){
            success = [fileManager copyItemAtPath:path toPath:filePath error:&error];
        }
        if (!success) {
            NSAssert1(0, @"Failed to copy Plist. Error %@", [error localizedDescription]);
        }
        memory = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"%@",filePath);
    }
    return self;
}

-(NSDictionary *)fetchInboundJourney{
    return [memory objectForKey:InboundJourney];
}

-(NSDictionary *)fetchOutboundJourney{
    return [memory objectForKey:OutboundJourney];
}

@end
