//
//  RequestOperation.m
//  NTOUMobile
//
//  Created by mini server on 13/1/1.
//
//

#import "RequestOperation.h"

@implementation RequestOperation
@synthesize RequestDelegate;
@synthesize connection;
- (id)initWithRequest:(NSURLRequest *)request {
    if (self = [self init]) {
        _request = [request retain];
        _data = [[NSMutableData data] retain];
    }
    return self;
}

- (void)dealloc {
    [_request release];
    [_data release];
    [super dealloc];
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)start {
    if (![self isCancelled]) {
        connection = [NSURLConnection connectionWithRequest:_request delegate:self];
    }
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    [RequestDelegate connection:connection didFailWithError:error];
}

- (void)connection:(NSURLConnection*)connection
    didReceiveData:(NSData*)data {
    NSLog(@"Did ReceiveData");
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
    NSLog(@"Will Finish");
    if (![self isCancelled]) {
         NSLog(@"Did Finish");
        [RequestDelegate connectionDidFinishLoading:_data];
    }
   
}

@end