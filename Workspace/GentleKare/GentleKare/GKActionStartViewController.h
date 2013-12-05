//
//  GKActionStartViewController.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKActionConfirmDelete.h"

@interface GKActionStartViewController : UIViewController
{
    IBOutlet UILabel *_lblActionDescrition;
    IBOutlet UIDatePicker *_pkrStartTime;
    
    GK_E_Action _action;
    
}

@property (nonatomic, weak) id <GKActionConfirmDelete> confirmDelegate;

-(void) loadAction: (GK_E_Action) action;

-(IBAction)onTriggerConfirm:(id)sender;

-(IBAction)onTriggerCancel:(id)sender;

@end
