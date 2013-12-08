//
//  GRY1Util.m
//  gary1
//
//  Created by 薛洪 on 13-11-26.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKUtil.h"

@implementation GKUtil

static const NSDateFormatter *DATEFORMATTER_DAYTIME;
static const NSDateFormatter *DATEFORMATTER_DAY;
static const NSDateFormatter *DATEFORMATTER_TIME;
static const NSDateFormatter *DATEFORMATTER_MONTHDAY;
static const NSDateFormatter *DATEFORMATTER_MONTHDAYTIME;

+(void) initialize{
    
    DATEFORMATTER_DAYTIME = [[NSDateFormatter alloc] init];
    [DATEFORMATTER_DAYTIME setTimeZone:[NSTimeZone localTimeZone]];
    [DATEFORMATTER_DAYTIME setDateFormat:@"yyyy/MM/dd hh:mm"];
    
    DATEFORMATTER_DAY = [[NSDateFormatter alloc] init];
    [DATEFORMATTER_DAY setTimeZone:[NSTimeZone localTimeZone]];
    [DATEFORMATTER_DAY setDateFormat:@"yyyy/MM/dd"];
    
    DATEFORMATTER_MONTHDAY = [[NSDateFormatter alloc] init];
    [DATEFORMATTER_MONTHDAY setTimeZone:[NSTimeZone localTimeZone]];
    [DATEFORMATTER_MONTHDAY setDateFormat:@"MM/dd"];
    
    DATEFORMATTER_MONTHDAYTIME = [[NSDateFormatter alloc] init];
    [DATEFORMATTER_MONTHDAYTIME setTimeZone:[NSTimeZone localTimeZone]];
    [DATEFORMATTER_MONTHDAYTIME setDateFormat:@"MM/dd hh:mm"];

    
    DATEFORMATTER_TIME = [[NSDateFormatter alloc] init];
    [DATEFORMATTER_TIME setTimeZone:[NSTimeZone localTimeZone]];
    [DATEFORMATTER_TIME setDateFormat:@"hh:mm"];
}

+(NSString*) nvl:(NSString*) src{
    return [self nvl:src to:@""];
}

+(NSString*) nvl:(NSString*) src to:(NSString*) defaultValue{
    return src==nil?defaultValue:src;
}

+(NSObject *) nvlObj:(NSObject *)src to:(NSObject *)defaultValue{
    return src==nil?defaultValue:src;
}

+(NSString *)dateToStr:(NSDate *)date{
    return [GKUtil nvl:[DATEFORMATTER_DAYTIME stringFromDate:date]];
}

+(NSString *)dateToStrAsDayOnly:(NSDate *)date{
    return [GKUtil nvl:[DATEFORMATTER_DAY stringFromDate:date]];
}

+(NSString *)dateToStrAsMonthDayOnly:(NSDate *)date{
    return [GKUtil nvl:[DATEFORMATTER_MONTHDAY stringFromDate:date]];
}

+(NSString *)dateToStrAsMonthDayTimeOnly:(NSDate *)date{
    return [GKUtil nvl:[DATEFORMATTER_MONTHDAYTIME stringFromDate:date]];
}

+(NSString* ) dateToStrAsTimeOnly: (NSDate*) date;{
    return [GKUtil nvl:[DATEFORMATTER_TIME stringFromDate:date]];
}

+(NSTimeInterval)getSeconds:(NSDate *)date{
    unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [cal components:unitFlags fromDate:date];
    return comp.hour * 60 * 60 + comp.minute * 60 + comp.second;
}

+(NSDate *)stripTime:(NSDate *)date{
    if(date==nil) {
        return nil;
    }
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:date];
    NSDate* dateOnly = [calendar dateFromComponents:components];
    return dateOnly;
}

+(NSDateComponents *)getDateCompForDate:(NSDate *)toDate compareTo:(NSDate *)fromDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    return components;
}

@end
