//
//  GKOverallViewController.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKActionStartViewController.h"

@interface GKOverallViewController : UIViewController{
    GKActionStartViewController *_vcActionStart;
}

-(IBAction)onTriggerFeeding:(id)sender;

@end
