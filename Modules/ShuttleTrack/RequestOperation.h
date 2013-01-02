//
//  RequestOperation.h
//  NTOUMobile
//
//  Created by mini server on 13/1/1.
//
//

@protocol RequestOperationDelegate <NSObject>
@required
- (void)connectionDidFinishLoading:(NSMutableData *)received;
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error;
@end

#import <Foundation/Foundation.h>
@interface RequestOperation : NSOperation<NSURLConnectionDelegate>{
     NSURLRequest* _request;
     NSMutableData* _data;
    id RequestDelegate;
    NSURLConnection *connection;
}
@property (nonatomic,assign) id RequestDelegate;
@property (retain) NSURLConnection *connection;
- (id)initWithRequest:(NSURLRequest *)request;

@end
