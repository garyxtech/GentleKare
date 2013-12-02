//
//  GKActionConfirmDelete.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-3.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GKActionConfirmDelete <NSObject>

-(void) didConfirmWithDate: (NSDate*) date forAction:(GK_E_Action) action isForBegin:(bool)isStart;

@end
