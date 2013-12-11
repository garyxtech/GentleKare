//
//  GRY1Util.h
//  gary1
//
//  Created by 薛洪 on 13-11-26.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKUtil : NSObject
{
    
}

+(NSString*) nvl:(NSString*) src;

+(NSString*) nvl:(NSString*) src to:(NSString*) defaultValue;

+(NSObject*) nvlObj:(NSObject*) src to:(NSObject*) defaultValue;

+(NSString*) dateToStr: (NSDate*) date;

+(NSString*) dateToStrAsMonthDayOnly: (NSDate*) date;

+(NSString*) dateToStrAsMonthDayTimeOnly: (NSDate*) date;

+(NSString*) dateToStrAsDayOnly: (NSDate*) date;

+(NSString*) dateToStrAsTimeOnly: (NSDate*) date;

+(NSTimeInterval) getSeconds: (NSDate*) date;

+(NSDate*) stripTime: (NSDate*) date;

+(NSDateComponents*) getDateCompForDate:(NSDate*) toDate compareTo:(NSDate*) fromDate;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
