//
//  GKActionStartViewController.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKActionStartViewController : UIViewController
{
    IBOutlet UILabel *_lblCurrentState;
    IBOutlet UILabel *_lblActionDescrition;
    IBOutlet UIDatePicker *_pkrStartTime;
    
    GK_E_Action _action;
}

-(void) loadAction: (GK_E_Action) action isStart:(bool) isStart;

-(IBAction)onTriggerConfirm:(id)sender;

-(IBAction)onTriggerCancel:(id)sender;

@end
