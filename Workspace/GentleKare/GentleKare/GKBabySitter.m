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
    [self updateActionGroup];
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

-(void) updateActionGroup{
    
    _arArActionByGroupIdx = [[NSMutableArray alloc] init];
    _arDaysSorted = nil;
    
    NSMutableArray* arDays = [[NSMutableArray alloc] init];
    for(GKAction *curr in [_baby recentActions]){
        NSDate* keyDate = [self keyDate:curr];
        if(keyDate == nil){
            continue;
        }
        NSDate* day = [GKUtil stripTime:keyDate];
        if([arDays containsObject:day]){
            continue;
        }
        [arDays addObject:day];
    }
    
    _arDaysSorted = [arDays sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate* d1 = (NSDate*) obj1;
        NSDate* d2 = (NSDate*) obj2;
        return [d2 compare:d1];
    }];
    
    for(GKAction *curr in [_baby recentActions]){
        
        NSDate* keyDate = [self keyDate:curr];
        if(keyDate == nil){
            continue;
        }
        
        NSDate* day = [GKUtil stripTime:keyDate];
        NSUInteger idx = [_arDaysSorted indexOfObject:day];
        
        if(idx>=[_arArActionByGroupIdx count]){
            for(int i=[_arArActionByGroupIdx count]; i<=idx; i++){
                NSMutableArray *arAction = [[NSMutableArray alloc] init];
                [_arArActionByGroupIdx addObject:arAction];
            }
        }
        
        NSMutableArray* arAction = [_arArActionByGroupIdx objectAtIndex:idx];
        
        [arAction addObject:curr];
    }
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
    [[self inst] updateActionGroup];
}

+(void)finishAt:(NSDate *)endTime{
    GKAction *lastAction = [[GKBabySitter inst] _getLastUnfinishedAction];
    lastAction.endTime = endTime;
    [[self inst] updateCurrAction];
    [[self inst] save];
    [[self inst] updateActionGroup];
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
            return @"喝奶";
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

+(int)getGroupCount{
    return [[self inst] _getGroupCount];
}

-(int) _getGroupCount{
    return [_arArActionByGroupIdx count];
}

-(NSDate*) keyDate:(GKAction*) action{
    return action.endTime == nil?action.startTime:action.endTime;
}

+(NSArray *)getActionForGroupIdx:(NSInteger)idx{
    return [[self inst] _getActionForGroupIdx:idx];
}

-(NSArray *)_getActionForGroupIdx:(NSInteger)idx{
    if([_arArActionByGroupIdx count] > idx){
        return [_arArActionByGroupIdx objectAtIndex:idx];
    }
    return nil;
}

+(NSObject *)getGroupCompareKeyForIdx:(NSInteger)idx{
    return [[self inst] _getGroupCompareKeyForIdx:idx];
}

-(NSObject *)_getGroupCompareKeyForIdx:(NSInteger)idx{
    return [_arDaysSorted objectAtIndex:idx];
}



@end
