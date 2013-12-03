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
#import "GKActionConfirmDelete.h"

@interface GKOverallViewController : UIViewController<GKActionConfirmDelete>{
    
    IBOutlet UILabel *_lblCurrentAction;
    IBOutlet UILabel *_lblBabyName;
    
    IBOutlet UIButton *_btnFeed;
    IBOutlet UIButton *_btnSleep;
    IBOutlet UIButton *_btnPlay;
    IBOutlet UIButton *_btnDispose;
    IBOutlet UIButton *_btnExtract;
    
    GKActionStartViewController *_actionStartController;
    GKActionEndViewController *_actionEndController;
}

-(IBAction)onTriggerAction:(id)sender;

@end
