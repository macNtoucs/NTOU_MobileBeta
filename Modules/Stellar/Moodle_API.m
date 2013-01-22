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
    // NSDictionary *dictionary = [self queryFunctionType:@"login" PostString:finailPost];
    NSDictionary *dictionary;
    bool validString=false;
    NSDictionary *postDic1;
    do{
        struct timeval t;
        gettimeofday(&t, NULL);
        long msec = (t.tv_sec * 1000 + t.tv_usec / 1000);
        long forEncrpt = msec%100000000;
        // setup post string
        NSString * encrypt_username =  [Moodle_API encryptUseDES:username key:[NSString stringWithFormat:@"%ld",forEncrpt]];
        NSString * encrypt_password =  [Moodle_API encryptUseDES:password key:[NSString stringWithFormat:@"%ld",forEncrpt]];
        
        
        postDic1 =[[NSDictionary alloc]initWithObjectsAndKeys:
                                 encrypt_username,@"username",
                                 encrypt_password,@"password",
                                 [NSString stringWithFormat:@"%ld",msec],@"now", nil];
        
        //NSLog(@"加密username=>%@",encrypt_username );
        //NSLog(@"加密password=>%@",encrypt_password );
        if ( ![self checkIsStringIncludePulseSymbol:encrypt_username] &&  ![self checkIsStringIncludePulseSymbol:encrypt_password]) validString = true;
        
        
       }while (!validString);
        NSString *jsonRequest = [postDic1 JSONRepresentation];
        NSString *finailPost = [NSString stringWithFormat:@"json=%@",jsonRequest];
        dictionary = [self queryFunctionType:@"login" PostString:finailPost];
        if([[dictionary allValues]count]>1) {
            NSLog(@"登入成功");
        }
    
    
    return dictionary;
 }

+(NSDictionary *)GetCourse_AndUseToken:(NSString*)token{
    NSDictionary *postDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"stid", nil];
    NSString *jsonRequest = [postDic JSONRepresentation];
    NSString *finailPost = [NSString stringWithFormat:@"json=%@",jsonRequest];
    
    NSDictionary *dictionary = [self queryFunctionType:@"getCourse" PostString:finailPost];
    
   
    return dictionary;
}


+(NSDictionary* )GetCourseInfo_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSDictionary *postDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"stid",cosID,@"cosid",clsID,@"clsid",nil];
    NSString *jsonRequest = [postDic JSONRepresentation];
    NSString *finailPost = [NSString stringWithFormat:@"json=%@",jsonRequest];
    NSDictionary *dictionary = [self queryFunctionType:@"CourseInfo" PostString:finailPost];
     return dictionary;

}

+(NSDictionary* )GetMoodleInfo_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSDictionary *postDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"stid",cosID,@"cosid",clsID,@"clsid",nil];
    NSString *jsonRequest = [postDic JSONRepresentation];
    NSString *finailPost = [NSString stringWithFormat:@"json=%@",jsonRequest];
    NSDictionary *dictionary = [self queryFunctionType:@"getMoodleInfo" PostString:finailPost];
    return dictionary;
}

+(NSDictionary* )GetGrade_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSDictionary *postDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"stid",cosID,@"cosid",clsID,@"clsid",nil];
    NSString *jsonRequest = [postDic JSONRepresentation];
    NSString *finailPost = [NSString stringWithFormat:@"json=%@",jsonRequest];
    NSDictionary *dictionary = [self queryFunctionType:@"getGrade" PostString:finailPost];
    return dictionary;
}

+(NSDictionary* )GetMoodleID_AndUseToken:(NSString *)token courseID:(NSString *)cosID classID:(NSString *)clsID{
    NSDictionary *postDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"stid",cosID,@"cosid",clsID,@"clsid",nil];
    NSString *jsonRequest = [postDic JSONRepresentation];
    NSString *finailPost = [NSString stringWithFormat:@"json=%@",jsonRequest];
    NSDictionary *dictionary = [self queryFunctionType:@"getMoodleID" PostString:finailPost];
    return dictionary;
}

@end
