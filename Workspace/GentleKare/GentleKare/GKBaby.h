//
//  GKBaby.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-2.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GKAction;

@interface GKBaby : NSManagedObject

@property (nonatomic, retain) NSNumber * currAction;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) GKAction *recentActions;

@end
