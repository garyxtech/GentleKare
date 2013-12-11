//
//  GKActionDetailViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-10.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKActionDetailViewController.h"

@interface GKActionDetailViewController ()

@end

@implementation GKActionDetailViewController{
    GKAction* _action;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtStartTime.inputView = self.pkrTime;
    self.txtEndTime.inputView = self.pkrTime;
}

-(void)loadAction:(GKAction *)action{
    _action = [[GKBabySitter inst] getTempAction];
    _action.actionID = action.actionID;
    _action.actionType = [action.actionType copy];
    _action.startTime = [action.startTime copy];
    _action.endTime = [action.endTime copy];
}

-(void)viewDidAppear:(BOOL)animated{
    [self updateInfo];
}

-(void) updateInfo{
    self.lblActionType.text = [[GKBabySitter inst] getActionDescription:[_action.actionType intValue]];
    self.txtStartTime.text = [GKUtil dateToStr:_action.startTime];
    self.txtEndTime.text = [GKUtil dateToStr:_action.endTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startPickDate:(id)sender{
    self.pkrTime.hidden = false;
    NSDate* date = nil;
    if(sender == self.txtStartTime){
        date = _action.startTime;
        self.btnPickOK.hidden = false;
    }else if(sender == self.txtEndTime){
        date = _action.endTime;
        self.btnPickOK.hidden = false;
    }
    self.pkrTime.date = date;
}

- (IBAction)pickerOK:(id)sender {
    NSDate* date = self.pkrTime.date;
    if([self.txtStartTime isFirstResponder]){
        _action.startTime = date;
        [self.txtStartTime resignFirstResponder];
    }else if([self.txtEndTime isFirstResponder]){
        _action.endTime = date;
        [self.txtEndTime resignFirstResponder];
    }
    self.pkrTime.hidden = true;
    self.btnPickOK.hidden = true;
    [self updateInfo];
}

- (IBAction)onSaveDetail:(id)sender {
    [[GKBabySitter inst] updateActionBySrc:_action];
    _action = nil;
    [self dismiss];
}

- (IBAction)onDelete:(id)sender {
    NSString* desc = [[GKBabySitter inst] getActionDescription:[_action.actionType intValue]];
    NSString* msg = [NSString stringWithFormat:@"删除本条'%@'记录?", desc];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确认删除" message:msg delegate:self cancelButtonTitle:@"按错了" otherButtonTitles:@"好的，确认删除", nil];
    [alert show];
}

- (void) dismiss{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [[GKBabySitter inst] deleteActionByID:_action.actionID];
        _action = nil;
        [self dismiss];
    }
}

@end
