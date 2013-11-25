//
//  HPAppDelegate.h
//  Hyponosister
//
//  Created by 薛 洪 on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPHyponosisView.h"

@interface HPAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate>
{
    HPHyponosisView *view;
}
@property (strong, nonatomic) UIWindow *window;

@end
