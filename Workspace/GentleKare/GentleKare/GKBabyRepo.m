//
//  GKBabyRepo.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-2.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKBabyRepo.h"

@implementation GKBabyRepo{
    NSManagedObjectContext* _context;
    NSManagedObjectModel* _model;
    NSEntityDescription* _entityDescGKBaby;
    NSEntityDescription* _entityDescGKAction;
}

static GKBabyRepo *_instance;

+(GKBabyRepo*) inst{
    if(_instance==nil){
        _instance = [[GKBabyRepo alloc] init];
        [_instance initRepo];
    }
    return _instance;
}

-(void) initRepo{
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GentleKare" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    NSManagedObjectContext* ctx;
    [self initContext:&ctx forPath:@"GentleKare.sqlite"];
    _context = ctx;
    
    _entityDescGKBaby = [NSEntityDescription entityForName:@"GKBaby" inManagedObjectContext:_context];
    _entityDescGKAction = [NSEntityDescription entityForName:@"GKAction" inManagedObjectContext:_context];
    
}

-(void) initContext:(NSManagedObjectContext**) ctx forPath:(NSString*) path{
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:path];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator* coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    if (![coord addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    *ctx = [[NSManagedObjectContext alloc] init];
    
    [*ctx setPersistentStoreCoordinator:coord];
    
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(GKBaby *)findOrCreateBaby{
    GKBaby* baby = [self findFirstBaby];
    if(baby==nil){
        baby = [self createBabyByName:@"宝宝"];
    }
    return baby;
}

-(GKBaby*) findFirstBaby{
    NSFetchRequest* fetchFindByName = [_model fetchRequestFromTemplateWithName:@"FindFirstBaby" substitutionVariables:nil];
    NSError *error;
    NSArray *result = [_context executeFetchRequest:fetchFindByName error:&error];
    GKBaby* ret = (GKBaby*) [result firstObject];
    return ret;
}

-(GKBaby*) findBabyByName:(NSString*) name{
    NSFetchRequest* fetchFindByName = [_model fetchRequestFromTemplateWithName:@"FindBabyByName" substitutionVariables:@{@"NAME": name}];
    NSError *error;
    NSArray *result = [_context executeFetchRequest:fetchFindByName error:&error];
    GKBaby* ret = (GKBaby*) [result firstObject];
    return ret;
}

-(GKBaby*) createBabyByName:(NSString*) name{
    GKBaby* baby = [NSEntityDescription insertNewObjectForEntityForName:@"GKBaby" inManagedObjectContext:_context];
    baby.name = name;
    NSError *error;
    [_context save:&error];
    return baby;
}

-(NSArray *)fetchActionsAfterTimeUntilNow:(NSDate *)time{
    NSDate* timeMax = [NSDate date];
    NSFetchRequest* fetchActionAfterTime = [_model fetchRequestFromTemplateWithName:@"FetchAcitonAfterTimeUntilMax" substitutionVariables:@{@"TIME": time, @"TIMEMAX":timeMax}];
    NSError *error;
    NSArray *result = [_context executeFetchRequest:fetchActionAfterTime error:&error];
    return result;
}

-(NSArray *)fetchActionsAfterTime:(NSDate *)time{
    NSFetchRequest* fetchActionAfterTime = [_model fetchRequestFromTemplateWithName:@"FetchAcitonAfterTime" substitutionVariables:@{@"TIME": time}];
    NSError *error;
    NSArray *result = [_context executeFetchRequest:fetchActionAfterTime error:&error];
    return result;
}

-(void)save{
    NSError *error;
    [_context save:&error];
}

-(GKAction *)getNewAction{
    GKAction* action = [[GKAction alloc] initWithEntity:_entityDescGKAction insertIntoManagedObjectContext:nil];
    return action;
}

-(void)saveAction:(GKAction *)action{
    [_context insertObject:action];
    [self save];
}


-(void) deleteActionByID:(NSNumber*) actionID{
    GKAction* action = [self getActionByID:actionID];
    if(actionID!=nil){
        [_context deleteObject:action];
        [self save];
    }
}

-(void) updateActionBySrc:(GKAction*) src{
    GKAction* action = [self getActionByID:src.actionID];
    if(action!=nil){
        action.actionType = src.actionType;
        action.startTime = src.startTime;
        action.endTime = src.endTime;
        [self save];
    }
}

-(GKAction*) getActionByID:(NSNumber*) actionID{
    NSFetchRequest* fetchActionByID = [_model fetchRequestFromTemplateWithName:@"FetchActionByActionID" substitutionVariables:@{@"ID": actionID}];
    NSError *error;
    NSArray *result = [_context executeFetchRequest:fetchActionByID error:&error];
    if([result count]>0){
        return [result firstObject];
    }else{
        return nil;
    }
}


@end
