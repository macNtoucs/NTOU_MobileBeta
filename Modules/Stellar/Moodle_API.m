//
//  Des_decrypt.m
//  APITest
//
//  Created by R MAC on 12/12/7.
//  Copyright (c) 2012年 R MAC. All rights reserved.
//

#import "Moodle_API.h"
#import "CommonCryptor.h"
#import "SBJson.h"


@implementation Moodle_API


static Byte iv[] = {1,2,3,4,5,6,7,8};

+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
 {
     NSString *ciphertext = nil;
     const char *textBytes = [plainText UTF8String];
     NSUInteger dataLength = [plainText length];
     unsigned char buffer[1024];
     memset(buffer, 0, sizeof(char));
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                              kCCOptionPKCS7Padding,
                                              [key UTF8String], kCCKeySizeDES,
                                              iv,
                                              textBytes, dataLength,
                                              buffer, 1024,
                                              &numBytesEncrypted);
     if (cryptStatus == kCCSuccess) {
         NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
         ciphertext = [data base64Encoding];
         }
     return ciphertext;
     }


+(NSDictionary *)queryFunctionType:(NSString *) type PostString:(NSString *)finailPost{
    // get response
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSMutableURLRequest * jsonQuest = [NSMutableURLRequest new];
    NSString * queryURL = [NSString stringWithFormat:@"http://140.121.197.103:2223/iNTOUServer/%@.do",type];
    [jsonQuest setURL:[NSURL URLWithString:queryURL]];
    [jsonQuest setHTTPMethod:@"POST"];
    [jsonQuest addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    
    [jsonQuest setHTTPBody:[finailPost dataUsingEncoding:NSUTF8StringEncoding]];
    //NSLog(@"Request = %@",finailPost);
    //NSLog(@"jsonQuest = %@",[jsonQuest HTTPBody]);
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:jsonQuest
                                                 returningResponse:&urlResponse
                                                             error:&error
                            ];
    
    //NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    return dictionary;

}

+(bool)checkIsStringIncludePulseSymbol:(NSString*) input{
    NSString * plusSymbol = @"%";
    NSRange check = [input rangeOfString:plusSymbol];
    if (check.length) return true;
    else false;
}

+(NSDictionary *)Login:(NSString *)username andPassword:(NSString*)password{    
    
    NSString *path =  [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"Login"];
    NSString*responseString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseData options: 0 error: &e];
    return dic;
 }

+(NSDictionary *)GetCourse_AndUseToken:(NSString*)token{
    NSString *path =  [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"Course"];
    NSString*responseString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseData options: 0 error: &e];
    return dic;
}


+(NSDictionary* )GetCourseInfo_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSString *path =  [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"CourseInfo"];
    NSString*responseString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseData options: 0 error: &e];
    return dic;
}

+(NSDictionary* )GetMoodleInfo_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSString *path =  [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"MoodleInfo"];
    NSString*responseString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseData options: 0 error: &e];
    return dic;
}

+(NSDictionary* )GetGrade_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSString *path =  [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"Grade"];
    NSString*responseString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseData options: 0 error: &e];
    return dic;
}

+(NSDictionary* )GetMoodleID_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSString *path =  [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"MoodleID"];
    NSString*responseString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseData options: 0 error: &e];
    return dic;
}

@end
