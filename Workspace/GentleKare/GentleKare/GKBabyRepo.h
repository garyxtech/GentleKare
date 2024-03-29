//
//  GKBabyRepo.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-2.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GKBabyRepo : NSObject
{
}

+(GKBabyRepo*) inst;

-(GKBaby*) findOrCreateBaby;

-(NSArray*) fetchActionsAfterTime: (NSDate*) time;

-(NSArray*) fetchActionsAfterTimeUntilNow: (NSDate*) time;

-(GKAction*) getNewAction;

-(void) save;

-(void) saveAction:(GKAction*)action;

-(void) deleteActionByID:(NSNumber*) actionID;

-(void) updateActionBySrc:(GKAction*) src;

-(GKAction*) getActionByID:(NSNumber*) actionID;

@end
