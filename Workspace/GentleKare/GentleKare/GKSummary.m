//
//  GKBabyToday.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-10.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKSummary.h"

@implementation GKSummary
{
    NSMutableDictionary* _dictCountForActions;
    NSMutableDictionary* _dictSecsForActions;
}

-(id)init{
    self = [super init];
    if(self){
        _dictCountForActions = [[NSMutableDictionary alloc] init];
        _dictSecsForActions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) analyzeActions:(NSArray *)actions{
    
    for(GKAction* action in actions){
        
        NSNumber* count = [_dictCountForActions objectForKey:action.actionType];
        if(count==nil){
            count = [NSNumber numberWithInt:0];
        }
        int val = [count intValue] + 1;
        [_dictCountForActions setObject:[NSNumber numberWithInt:val] forKey:action.actionType];
        
        NSNumber* secs = [_dictSecsForActions objectForKey:action.actionType];
        if(secs==nil){
            secs = [NSNumber numberWithInt:0];
        }
        
        NSTimeInterval currInteval = [action.endTime timeIntervalSinceDate:action.startTime];
        val = [secs intValue] + currInteval;
        [_dictSecsForActions setObject:[NSNumber numberWithInt:val] forKey:action.actionType];
    }
}

-(int)getCountForAction:(GK_E_Action)actionType{
    NSNumber* val = [_dictCountForActions objectForKey:[NSNumber numberWithInt:actionType]];
    if(val != nil){
        return [val intValue];
    }else{
        return 0;
    }
}

-(NSTimeInterval)getTotalSecondsForAction:(GK_E_Action)actionType{
    NSNumber* val = [_dictSecsForActions objectForKey:[NSNumber numberWithInt:actionType]];
    if(val != nil){
        return [val intValue];
    }else{
        return 0;
    }
}

@end
