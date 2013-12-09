//
//  GKBabyDetailViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKBabyDetailViewController.h"

@interface GKBabyDetailViewController ()

@end

@implementation GKBabyDetailViewController{
    NSDate* _pickedDate;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadBabyDetail];
    [self.lblBirthday setInputView:self.pkrDate];
}

-(void) loadBabyDetail{
    GKBaby* baby = [[GKBabySitter inst] baby];
    [self.lblName setText:baby.name];
    if(baby.birthday!=nil){
        [self.lblBirthday setText:[GKUtil dateToStrAsDayOnly:baby.birthday]];
        _pickedDate = baby.birthday;
    }else{
        [self.lblBirthday setText:@"未设定"];
        _pickedDate = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmDetail:(id)sender {
    GKBaby* baby = [[GKBabySitter inst] baby];
    baby.name = self.lblName.text;
    baby.birthday = _pickedDate;
    [[GKBabySitter inst] save];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)cancelDetail:(id)sender {
    [[GKBabySitter inst] reloadBabyDetail];
    [self.navigationController popViewControllerAnimated:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (IBAction)confirmBirthdayPick:(id)sender {

    _pickedDate = [self.pkrDate date];
    [self.lblBirthday setText:[GKUtil dateToStrAsDayOnly:_pickedDate]];
    
    [self.lblBirthday resignFirstResponder];
    self.btnPickDateOK.hidden = true;
    self.btnPickDateOK.hidden = true;
}

- (IBAction)startPickBirthday:(id)sender {
    if(_pickedDate!=nil){
        [self.pkrDate setDate:_pickedDate];
    }
    self.btnPickDateOK.hidden = false;
    self.pkrDate.hidden = false;
}

@end
