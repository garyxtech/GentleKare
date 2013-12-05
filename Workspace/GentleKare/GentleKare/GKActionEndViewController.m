//
//  GKActionEndViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-2.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKActionEndViewController.h"

@interface GKActionEndViewController ()

@end

@implementation GKActionEndViewController

@synthesize confirmDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) resetData{
    _action = [GKBabySitter getCurrBabyAction];
    GKAction *lastAction = [GKBabySitter getLastUnfinishedAction];
    [_lblActionDescrition setText:[GKBabySitter getCurrBabyActionDescription]];
    [_pkrEndTime setDate:[NSDate date]];
    [_lblLastStartTime setText:[GKUtil dateToStr:lastAction.startTime]];
    [_pkrEndTime setMinimumDate:lastAction.startTime];
}

-(void)onTriggerCancel:(id)sender{
    [self dismissSelf:nil];
}

-(void)onTriggerConfirm:(id)sender{
    [self dismissSelf:^{
        NSDate *date = [_pkrEndTime date];
        [confirmDelegate didConfirmWithDate:date forAction:_action isForBegin:false];
    }];
}

-(void)dismissSelf:(void (^)(void))completion {
    [self dismissViewControllerAnimated:true completion:completion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
