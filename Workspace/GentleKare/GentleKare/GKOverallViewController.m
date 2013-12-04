//
//  GKOverallViewController.m
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKOverallViewController.h"

@interface GKOverallViewController ()

@end

@implementation GKOverallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _actionStartController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC_ACTION_START"];
    UIView *view = _actionStartController.view;
    _actionStartController.confirmDelegate = self;
    NSLog(@"%@", view);
    
    _actionEndController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC_ACTION_END"];
    view = _actionEndController.view;
    _actionEndController.confirmDelegate = self;
    NSLog(@"%@", view);
    
    view = nil;
    
    [self loadBabyData];
    
    [self updateOverviewInfo];
}

-(void) loadBabyData{
    [_lblBabyName setText:[GKBabySitter baby].name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTriggerAction:(id)sender{
    GK_E_Action action = [self getTriggerAction:sender];
    if([GKBabySitter isLastActionInProgress] && action != GK_E_Action_DISPOSE){
        [_actionEndController resetData];
        [self presentViewController:_actionEndController animated:true completion:nil];
    }else{
        if(action == GK_E_Action_IDLE){
            return;
        }
        [_actionStartController loadAction:action];
        [self presentViewController:_actionStartController animated:true completion:nil];
    }
}

-(GK_E_Action)getTriggerAction:(id)sender{
    if(sender == _btnFeed){
        return GK_E_Action_FEED;
    }
    if(sender == _btnDispose){
        return GK_E_Action_DISPOSE;
    }
    if(sender == _btnPlay){
        return GK_E_Action_PLAY;
    }
    if(sender == _btnSleep){
        return GK_E_Action_SLEEP;
    }
    return GK_E_Action_IDLE;
}

-(void)didConfirmWithDate:(NSDate *)date forAction:(GK_E_Action)action isForBegin:(bool)isStart{
    if(isStart){
        [GKBabySitter action:action at:date];
    }else{
        [GKBabySitter finishAt:date];
    }
    [self updateOverviewInfo];
}

-(void) updateOverviewInfo{
    [_lblCurrentAction setText:[[GKBabySitter getCurrBabyActionDescription] stringByAppendingString:@"中"]];
    [self updateActionAvailability];
}

-(void) updateActionAvailability{
    GK_E_Action action = [GKBabySitter getCurrBabyAction];
    _btnFeed.hidden = _btnSleep.hidden = _btnPlay.hidden = true;
    if(action == GK_E_Action_IDLE){
        _btnFeed.hidden = _btnSleep.hidden = _btnPlay.hidden = false;
    }else{
        switch (action) {
            case GK_E_Action_FEED:
                _btnFeed.hidden = false;
                break;
            case GK_E_Action_PLAY:
                _btnPlay.hidden = false;
                break;
            case GK_E_Action_SLEEP:
                _btnSleep.hidden = false;
                break;
            default:
                break;
        }
    }
}

@end
