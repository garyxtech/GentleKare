//
//  WAIMapPoint.m
//  Whereami
//
//  Created by 薛 洪 on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WAIMapPoint.h"

@implementation WAIMapPoint

@synthesize coordinate, title;

-(id) init{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43, 89) title:@"default"];
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)cor title:(NSString *)t{
    self = [super init];
    if(self){
        coordinate = cor;
        [self setTitle:t];
    }
    return self;
}

@end
