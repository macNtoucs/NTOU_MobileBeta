//
//  Des_decrypt.h
//  APITest
//
//  Created by R MAC on 12/12/7.
//  Copyright (c) 2012年 R MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Moodle_API : NSObject

+(NSDictionary *)Login:(NSString *)username andPassword:(NSString*)password;

+(NSDictionary *)GetCourse_AndUseToken:(NSString*)token; //依照學生學號與學年度回傳選課課表
@end
