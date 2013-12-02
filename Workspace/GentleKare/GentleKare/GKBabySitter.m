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
    GKAction* lastAction = [[[_baby recentActions] allObjects] firstObject];
    if(lastAction){
        if(lastAction.endTime){
            _baby.currAction = GK_E_Action_IDLE;
        }else{
            _baby.currAction = [lastAction actionType];
        }
    }else{
        _baby.currAction = GK_E_Action_IDLE;
    }
}

-(GKBaby*) _currBaby{
    return _baby;
}

+(GKBaby*) baby{
    return [[GKBabySitter inst] _currBaby];
}

+(void)action:(GK_E_Action)action at:(NSDate *)startTime{
    [GKBabySitter baby].currAction = [NSNumber numberWithInt:action];
}

+(void)finishAt:(NSDate *)endTime{
    [GKBabySitter baby].currAction = [NSNumber numberWithInt:GK_E_Action_IDLE];
}

+(GK_E_Action)getCurrBabyAction{
    return (GK_E_Action)[GKBabySitter baby].currAction;
}

+(NSString *)getCurrBabyActionDescription{
    return [GKBabySitter getActionDescription:(GK_E_Action)[GKBabySitter baby].currAction];
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
