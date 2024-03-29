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
    NSDate* _lastBabyDetailChangedTime;
    NSDate* _lastActionChangedTime;
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
    _periodType = GK_E_PERIOD_LAST31DAYS;
    [self reloadBabyDetail];
    _recentActions = [[NSMutableArray alloc] init];
    [self updateActionGroup];
}

-(void) reloadBabyDetail{
    _baby = [_repo findOrCreateBaby];
    _lastBabyDetailChangedTime = [NSDate date];
}

-(NSDate*) getLastBabyDetailChangedTime{
    return _lastBabyDetailChangedTime;
}

-(NSDate *) getLastActionChangedTime{
    return _lastActionChangedTime;
}

-(NSDate*) getDateSinceSetPeriod{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDate* now = [NSDate date];
    NSDateComponents* comp = [[NSDateComponents alloc] init];
    switch (_periodType) {
        case GK_E_PERIOD_LAST24HOURS:
            [comp setHour:-24];
            break;
        case GK_E_PERIOD_LAST31DAYS:
            [comp setDay:-31];
            break;
        case GK_E_PERIOD_LAST12MONTHS:
            [comp setMonth:-12];
            break;
        default:
            return nil;
    }
    return [cal dateByAddingComponents:comp toDate:now options:0];
}

-(void) updateActionGroup{
    
    NSDate* boundDate = [self getDateSinceSetPeriod];
    NSArray* foundActions = [_repo fetchActionsAfterTime:boundDate];
    [_recentActions removeAllObjects];
    [_recentActions addObjectsFromArray:foundActions];
    
    _lastActionChangedTime = [NSDate date];
    
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
    
    for(int i=0; i<[_arArActionByGroupIdx count];i++){
        NSMutableArray* curr = [_arArActionByGroupIdx objectAtIndex:i];
        NSArray* sorted = [curr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            GKAction* a1 = (GKAction*) obj1;
            GKAction* a2 = (GKAction*) obj2;
            return [a2.endTime compare:a1.endTime];
        }];
        [curr removeAllObjects];
        [curr addObjectsFromArray:sorted];
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
    _actionOnHold = [_repo getNewAction];
    _actionOnHold.actionType = [NSNumber numberWithInt:action];
    _actionOnHold.startTime = startTime;
}

-(void)finishAt:(NSDate *)endTime{
    _actionOnHold.endTime = endTime;
    _actionOnHold.actionID = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    [_repo saveAction:_actionOnHold];
    _actionOnHold = nil;
    _lastActionChangedTime = [NSDate date];
    [self updateActionGroup];
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

-(NSDate *)getGroupCompareKeyForIdx:(NSInteger)idx{
    return (NSDate*)[_arDaysSorted objectAtIndex:idx];
}

-(void)disposeNow{
    NSDate* now = [NSDate date];
    GKAction* disposeAction = [_repo getNewAction];
    disposeAction.actionType = [NSNumber numberWithInt:GK_E_Action_DISPOSE];
    disposeAction.startTime = now;
    disposeAction.endTime = now;
    [_repo saveAction:disposeAction];
    _lastActionChangedTime = now;
    [self updateActionGroup];
}

-(void) save{
    _lastBabyDetailChangedTime = [NSDate date];
    [[GKBabyRepo inst] save];
}

-(GKSummary*) getTodaySummary{
    GKSummary* sum = [[GKSummary alloc] init];
    NSDate* todayZero = [NSDate date];
    todayZero = [GKUtil stripTime:todayZero];
    NSArray* actions = [[GKBabyRepo inst] fetchActionsAfterTimeUntilNow:todayZero];
    [sum analyzeActions:actions];
    return sum;
}

-(GKAction *)getTempAction{
    return [_repo getNewAction];
}

-(void)deleteActionByID:(NSNumber *)actionID{
    [[GKBabyRepo inst] deleteActionByID:actionID];
    _lastActionChangedTime = [NSDate date];
    [self updateActionGroup];
}

-(void)updateActionBySrc:(GKAction *)src{
    [[GKBabyRepo inst] updateActionBySrc:src];
    _lastActionChangedTime = [NSDate date];
    [self updateActionGroup];
}

@end
