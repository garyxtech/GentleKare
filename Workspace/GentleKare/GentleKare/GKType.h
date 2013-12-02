//
//  GKType.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, GK_E_Action){
    GK_E_Action_IDLE=0,
    GK_E_Action_FEED,
    GK_E_Action_PLAY,
    GK_E_Action_SLEEP,
    GK_E_Action_DISPOSE
};