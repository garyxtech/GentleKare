//
//  GKBaby.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GKAction;

@interface GKBaby : NSManagedObject

@property (nonatomic, retain) NSNumber * currAction;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) GKAction *recentActions;

@end
