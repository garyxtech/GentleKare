//
//  GKActionStartViewController.m
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKActionStartViewController.h"

@interface GKActionStartViewController ()

@end

@implementation GKActionStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadAction: (GK_E_Action) action isStart:(bool) isStart{
    _action = action;
    [_lblCurrentState setText:[GKBabySitter getCurrBabyActionDescription]];
    [_lblActionDescrition setText:[GKBabySitter getActionDescription:action]];
}

-(void)onTriggerCancel:(id)sender{
    [self dismissSelf:nil];
}

-(void)onTriggerConfirm:(id)sender{
    [self dismissSelf:nil];
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
