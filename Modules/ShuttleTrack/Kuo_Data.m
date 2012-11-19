//
//  Kuo_Data.m
//  MIT Mobile
//
//  Created by mini server on 12/11/16.
//
//

#import "Kuo_Data.h"

@implementation Kuo_Data
static Kuo_Data *sharedData = nil;
@synthesize  ScheduleInfo;
@synthesize Stop;
@synthesize Index;
@synthesize IndexBase;
@synthesize Route;
@synthesize NextPageUrl;
+ (Kuo_Data *)sharedData {
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
        Stop = [[NSMutableArray alloc] init];
        Route = [[NSMutableArray alloc] init];
        NextPageUrl = [[NSMutableArray alloc] init];
        IndexBase = [[NSMutableArray alloc] init];
    /*ScheduleInfo = [[NSDictionary alloc]initWithObjectsAndKeys:
                    [[NSDictionary alloc]initWithObjectsAndKeys:
                     [NSMutableArray arrayWithObjects:
                      [NSString stringWithFormat:@"1813台北西站A棟 到 基隆 (經高速公路)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010236"],[NSString stringWithFormat:@"1819台北西站A棟 到 桃園國際機場 (經中山高)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010409"],[NSString stringWithFormat:@"1815台北西站A棟 到 金青中心 (經中山高)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010402"],[NSString stringWithFormat:@"1815台北西站A棟 到 法鼓山 (經金山車站)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010403"],[NSString stringWithFormat:@"1816台北西站A棟 到 桃園 (經中山高)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010404"],[NSString stringWithFormat:@"1818台北西站A棟 到 中壢 (經中山高)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010405"],[NSString stringWithFormat:@"1811台北西站A棟 到 宜蘭、羅東 (經濱海公路)"],[NSURL URLWithString:@"http://www.kingbus.com.tw/down2.php?li_code=1A010406"],nil],
                     @"台北西站A棟",nil],
                    @"1",nil];*/
        Index = [[NSArray arrayWithObjects:[NSNumber numberWithInt:9],[NSNumber numberWithInt:2],[NSNumber numberWithInt:7],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:1],[NSNumber numberWithInt:6],[NSNumber numberWithInt:6],[NSNumber numberWithInt:16],[NSNumber numberWithInt:7],[NSNumber numberWithInt:4],[NSNumber numberWithInt:2],[NSNumber numberWithInt:5],[NSNumber numberWithInt:8],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:4],[NSNumber numberWithInt:15],[NSNumber numberWithInt:1],[NSNumber numberWithInt:14],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:14],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:4],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:7],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil] retain];
        int base = 0;
        for (NSNumber*index in Index) {
            [IndexBase addObject:[NSNumber numberWithInt: base]];
            base+=[index intValue];
        }
        NSError* error;
        NSData* data = [[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.kingbus.com.tw/time&price.php"] encoding:NSUTF8StringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple* parser = [[TFHpple alloc] initWithHTMLData:data];
        NSArray *tableData_td  = [parser searchWithXPathQuery:@"//body//table//tr//tr//tr//tr//td//map//area"];
        for (TFHppleElement * attributeElement in tableData_td) {
            NSDictionary * contextArr = [attributeElement attributes];
            NSString* title = [contextArr objectForKey:@"title"];
            if (![title isEqualToString:@""]) {
                [Stop addObject:title];
            }
        }
        NSArray *tableData_div  = [parser searchWithXPathQuery:@"//body//table//tr//tr//tr//tr//td//div//table//table//tr//td//a"];
        for (TFHppleElement * attributeElement in tableData_div) {
            NSArray * contextArr = [attributeElement children];
            TFHppleElement * context = [contextArr objectAtIndex:0];
            NSString * stops = [context content];
            NSString *pureString = [[stops componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789/"] ] componentsJoinedByString:@""];
           // NSArray *strArray = [pureString componentsSeparatedByString:@" 到 "];
            [Route addObject:pureString];
        }
        for (TFHppleElement * attributeElement in tableData_div) {
            NSDictionary * contextArr = [attributeElement attributes];
            NSString* title = [contextArr objectForKey:@"href"];
            [NextPageUrl addObject:title];
        }
    }
    return self;
}



@end
