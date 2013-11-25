//
//  WAIMapPoint.h
//  Whereami
//
//  Created by 薛 洪 on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WAIMapPoint : NSObject<MKAnnotation>

-(id) initWithCoordinate:(CLLocationCoordinate2D) cor title: (NSString*) t;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@end
