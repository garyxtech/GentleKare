//
//  GKBabyToday.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-10.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKSummary : NSObject

-(void) analyzeActions:(NSArray*) actions;

-(int) getCountForAction:(GK_E_Action) actionType;

-(NSTimeInterval) getTotalSecondsForAction:(GK_E_Action) actionType;

@end
