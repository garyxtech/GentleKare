//
//  GKActionDetailViewController.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-10.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKActionDetailViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblActionType;
@property (weak, nonatomic) IBOutlet UITextField *txtStartTime;
@property (weak, nonatomic) IBOutlet UITextField *txtEndTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *pkrTime;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnPickOK;

- (IBAction)startPickDate:(id)sender;
- (IBAction)pickerOK:(id)sender;
- (IBAction)onSaveDetail:(id)sender;
- (IBAction)onDelete:(id)sender;

-(void) loadAction:(GKAction*) action;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
