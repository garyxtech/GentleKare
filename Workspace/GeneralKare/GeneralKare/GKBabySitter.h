//
//  GKBabySitter.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKBabySitter : NSObject
{
    GKBaby *_baby;
}

+(GK_E_Action) getCurrBabyAction;

+(NSString*) getCurrBabyActionDescription;

+(NSString*) getActionDescription:(GK_E_Action)action;

+(void) action:(GK_E_Action) action at:(NSDate*) startTime;

+(void) finishAt:(NSDate*) endTime;

@end
