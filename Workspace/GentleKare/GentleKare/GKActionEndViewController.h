//
//  GKActionEndViewController.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-2.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKActionConfirmDelete.h"

@class GKActionConfirmDelete;

@interface GKActionEndViewController : UIViewController
{
    IBOutlet UILabel *_lblCurrentState;
    IBOutlet UILabel *_lblActionDescrition;
    IBOutlet UIDatePicker *_pkrStartTime;
    
    GK_E_Action _action;
}

@property (nonatomic, weak) id <GKActionConfirmDelete> confirmDelegate;

-(void) resetData;

-(IBAction)onTriggerConfirm:(id)sender;

-(IBAction)onTriggerCancel:(id)sender;

@end
