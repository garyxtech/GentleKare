//
//  GKAction.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-11.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GKAction : NSManagedObject

@property (nonatomic, retain) NSNumber * actionID;
@property (nonatomic, retain) NSNumber * actionType;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;

@end
