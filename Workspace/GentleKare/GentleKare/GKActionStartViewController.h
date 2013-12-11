//
//  GKActionStartViewController.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKActionStartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblElapsedTime;
@property (weak, nonatomic) IBOutlet UIButton *btnEnd;
@property (weak, nonatomic) IBOutlet UIButton *btnDispose;

- (void) loadForAction:(GK_E_Action) action;

- (IBAction)endAction:(id)sender;
- (IBAction)triggerDispose:(id)sender;

-(void)updateElapseTime;

@end
