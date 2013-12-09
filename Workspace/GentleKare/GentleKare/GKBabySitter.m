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

@implementation GKBabySitter{
    GKBaby *_baby;
    GKBabyRepo *_repo;
    NSMutableArray *_recentActions;
    int _currGroupCount;
    NSMutableArray *_arArActionByGroupIdx;
    NSArray* _arDaysSorted;
    GK_E_PERIOD _periodType;
    GKAction* _actionOnHold;
}

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
        _repo = [GKBabyRepo inst];
    }
    return self;
}

-(void) initData{
    _periodType = GK_E_PERIOD_LAST24HOURS;
    _baby = [_repo findOrCreateBabyForName:@"川川"];
    _recentActions = [[NSMutableArray alloc] init];
    [self updateCurrAction];    
    [self updateActionGroup];
}

-(void) updateCurrAction{
    
    GK_E_Action foundActionType = GK_E_Action_IDLE;
    
    for(GKAction* currAction in [_recentActions reverseObjectEnumerator]){
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

-(NSDate*) getDateSinceSetPeriod{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDate* now = [NSDate date];
    NSDateComponents* comp = [[NSDateComponents alloc] init];
    switch (_periodType) {
        case GK_E_PERIOD_LAST24HOURS:
            [comp setHour:24];
            break;
        case GK_E_PERIOD_LAST31DAYS:
            [comp setDay:31];
            break;
        case GK_E_PERIOD_LAST12MONTHS:
            [comp setMonth:12];
            break;
        default:
            return nil;
    }
    return [cal dateByAddingComponents:comp toDate:now options:NSCalendarWrapComponents];
}

-(void) updateActionGroup{
    
    NSDate* boundDate = [self getDateSinceSetPeriod];
    NSArray* foundActions = [_repo fetchActionsAfterTime:boundDate];
    [_recentActions removeAllObjects];
    [_recentActions addObjectsFromArray:foundActions];
    
    _arArActionByGroupIdx = [[NSMutableArray alloc] init];
    _arDaysSorted = nil;
    
    NSMutableArray* arDays = [[NSMutableArray alloc] init];
    for(GKAction *curr in _recentActions){
        
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
    
    for(GKAction *curr in _recentActions){
        
        NSDate* keyDate = [self keyDate:curr];
        if(keyDate == nil){
            continue;
        }
        
        NSDate* day = [GKUtil stripTime:keyDate];
        NSUInteger idx = [_arDaysSorted indexOfObject:day];
        
        if(idx>=[_arArActionByGroupIdx count]){
            for(int i = (int)[_arArActionByGroupIdx count]; i<=idx; i++){
                NSMutableArray *arAction = [[NSMutableArray alloc] init];
                [_arArActionByGroupIdx addObject:arAction];
            }
        }
        
        NSMutableArray* arAction = [_arArActionByGroupIdx objectAtIndex:idx];
        
        [arAction addObject:curr];
    }
}

-(GKAction *) getLastUnfinishedAction{
    for(GKAction* currAction in [_recentActions reverseObjectEnumerator]){
        if(currAction.endTime){
            continue;
        }
        return currAction;
    }
    return nil;
}

-(GKBaby*) baby{
    return _baby;
}

-(void)action:(GK_E_Action)action at:(NSDate *)startTime{
    [self baby].currAction = [NSNumber numberWithInt:action];
    _actionOnHold = [_repo getNewAction];
    _actionOnHold.actionType = [NSNumber numberWithInt:action];
    _actionOnHold.startTime = startTime;
    if(action == GK_E_Action_DISPOSE){
        _actionOnHold.endTime = startTime;
    }
}

-(void)finishAt:(NSDate *)endTime{
    _actionOnHold.endTime = endTime;
    [_repo saveAction:_actionOnHold];
    _actionOnHold = nil;
    [self updateActionGroup];
}

-(GK_E_Action)getCurrBabyAction{
    return [_baby.currAction intValue];
}

-(NSString *)getCurrBabyActionDescription{
    GK_E_Action action = [_baby.currAction intValue];
    return [self getActionDescription:action];
}

-(NSString *)getActionDescription:(GK_E_Action)action{
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

-(bool)isLastActionInProgress{
    return [self getCurrBabyAction] != GK_E_Action_IDLE;
}

-(int)getGroupCount{
    return [self _getGroupCount];
}

-(int) _getGroupCount{
    return (int)[_arArActionByGroupIdx count];
}

-(NSDate*) keyDate:(GKAction*) action{
    return action.endTime == nil?action.startTime:action.endTime;
}

-(NSArray *)getActionForGroupIdx:(NSInteger)idx{
    if([_arArActionByGroupIdx count] > idx){
        return [_arArActionByGroupIdx objectAtIndex:idx];
    }
    return nil;
}

-(NSObject *)getGroupCompareKeyForIdx:(NSInteger)idx{
    return [self _getGroupCompareKeyForIdx:idx];
}

-(NSObject *)_getGroupCompareKeyForIdx:(NSInteger)idx{
    return [_arDaysSorted objectAtIndex:idx];
}

-(void)disposeNow{
    
}

-(void)cancelLastAction{
    
}


@end
