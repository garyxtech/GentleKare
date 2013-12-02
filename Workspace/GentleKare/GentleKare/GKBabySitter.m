//
//  GKBabySitter.m
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKBabySitter.h"
#import "GKType.h"
#import "GKBabyRepo.h"

@implementation GKBabySitter

static GKBabySitter *instance;

+(GKBabySitter*) inst{
    if(instance == nil){
        instance = [[GKBabySitter alloc] init];
        [instance initData];
    }
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}

-(void) initData{
    _baby = [GKBabyRepo findOrCreateBabyForName:@"川川"];
    [self updateCurrAction];
    [self save];
}

-(void) save{
    [GKBabyRepo save];
}

-(void) updateCurrAction{
    
    GK_E_Action foundActionType = GK_E_Action_IDLE;
    
    for(GKAction* currAction in [[[_baby recentActions] allObjects] reverseObjectEnumerator]){
        if([currAction.actionType intValue] == GK_E_Action_DISPOSE){
            continue;
        }
        if(currAction.endTime){
            continue;
        }
        foundActionType = (GK_E_Action) [currAction.actionType intValue];
        break;
    }
    
    _baby.currAction = [NSNumber numberWithInt:foundActionType];
}

-(GKAction *) _getLastUnfinishedAction{
    for(GKAction* currAction in [[[_baby recentActions] allObjects] reverseObjectEnumerator]){
        if(currAction.endTime){
            continue;
        }
        return currAction;
    }
    return nil;
}

-(GKBaby*) _currBaby{
    return _baby;
}

+(GKBaby*) baby{
    return [[GKBabySitter inst] _currBaby];
}

+(void)action:(GK_E_Action)action at:(NSDate *)startTime{
    [GKBabySitter baby].currAction = [NSNumber numberWithInt:action];
    GKAction *newAction = [GKBabyRepo createNewAction];
    newAction.actionType = [NSNumber numberWithInt:action];
    newAction.startTime = startTime;
    newAction.baby = [GKBabySitter baby];
    if(action == GK_E_Action_DISPOSE){
        [self finishAt:startTime];
    }
    [[self inst] updateCurrAction];
    [[self inst] save];
}

+(void)finishAt:(NSDate *)endTime{
    GKAction *lastAction = [[GKBabySitter inst] _getLastUnfinishedAction];
    lastAction.endTime = endTime;
    [[self inst] updateCurrAction];
    [[self inst] save];
}

+(GK_E_Action)getCurrBabyAction{
    return [[GKBabySitter baby].currAction intValue];
}

+(NSString *)getCurrBabyActionDescription{
    GK_E_Action action = [[GKBabySitter baby].currAction intValue];
    return [GKBabySitter getActionDescription:action];
}

+(NSString *)getActionDescription:(GK_E_Action)action{
    switch (action) {
        case GK_E_Action_IDLE:
            return @"呆左";
        case GK_E_Action_FEED:
            return @"喝奶奶";
        case GK_E_Action_PLAY:
            return @"玩耍";
        case GK_E_Action_SLEEP:
            return @"呼呼";
        case GK_E_Action_DISPOSE:
            return @"臭臭";
        default:
            return @"";
    }
}

+(bool)isLastActionInProgress{
    return [self getCurrBabyAction] != GK_E_Action_IDLE;
}


@end
