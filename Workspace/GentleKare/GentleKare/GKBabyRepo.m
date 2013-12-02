//
//  GKBabyRepo.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-2.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKBabyRepo.h"

@implementation GKBabyRepo

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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GentleKare.sqlite"];
    
    NSError *error = nil;
    _coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    if (![_coord addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:_coord];
    
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+(GKBaby *)findOrCreateBabyForName:(NSString *)name{
    GKBaby* baby = [[GKBabyRepo inst] findBabyByName:name];
    if(baby==nil){
        baby = [[GKBabyRepo inst] createBabyByName:name];
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

@end
