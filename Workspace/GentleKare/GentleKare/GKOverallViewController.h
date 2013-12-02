//
//  GKOverallViewController.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKActionStartViewController.h"
#import "GKActionEndViewController.h"

@interface GKOverallViewController : UIViewController{
    IBOutlet UILabel *_lblBabyName;
    
    GKActionStartViewController *_actionStartController;
    GKActionEndViewController *_actionEndController;
}

-(IBAction)onTriggerFeeding:(id)sender;

@end
