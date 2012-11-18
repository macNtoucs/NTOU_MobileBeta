//
//  KUO_Data_Bra2.h
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import <Foundation/Foundation.h>
#define InboundJourney @"去程"
#define OutboundJourney @"回程"
#define StationInformationCount 5
@interface KUO_Data_Bra2 : NSObject{
    NSMutableDictionary* memory;
}
+ (KUO_Data_Bra2 *)sharedData;

-(NSDictionary *)fetchInboundJourney;

-(NSDictionary *)fetchOutboundJourney;
@end
