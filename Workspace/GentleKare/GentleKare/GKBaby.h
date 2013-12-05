//
//  GKBaby.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-5.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GKAction;

@interface GKBaby : NSManagedObject

@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * currAction;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSSet *recentActions;
@end

@interface GKBaby (CoreDataGeneratedAccessors)

- (void)addRecentActionsObject:(GKAction *)value;
- (void)removeRecentActionsObject:(GKAction *)value;
- (void)addRecentActions:(NSSet *)values;
- (void)removeRecentActions:(NSSet *)values;

@end
