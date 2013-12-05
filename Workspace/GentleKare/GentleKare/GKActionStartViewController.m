//
//  GKActionStartViewController.m
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKActionStartViewController.h"
#import "GKActionConfirmDelete.h"

@interface GKActionStartViewController ()

@end

@implementation GKActionStartViewController

@synthesize confirmDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void) loadAction: (GK_E_Action) action{
    _action = action;
    [_lblActionDescrition setText:[GKBabySitter getActionDescription:action]];
    [_pkrStartTime setDate:[NSDate date]];
}

-(void)onTriggerCancel:(id)sender{
    [self dismissSelf:nil];
}

-(void)onTriggerConfirm:(id)sender{
    [self dismissSelf:^{
        NSDate *date = [_pkrStartTime date];
        [confirmDelegate didConfirmWithDate:date forAction:_action isForBegin:true];
    }];
}

-(void)dismissSelf:(void (^)(void))completion {
    [self dismissViewControllerAnimated:true completion:completion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_pkrStartTime setMaximumDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
