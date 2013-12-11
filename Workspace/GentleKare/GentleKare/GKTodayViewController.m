//
//  GKTodayViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-10.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKTodayViewController.h"

@interface GKTodayViewController ()

@end

@implementation GKTodayViewController{
    NSDate* _lastActionLoadTime;
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
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSDate* lastActionChangedTime = [[GKBabySitter inst] getLastActionChangedTime];
    
    if(_lastActionLoadTime != nil && lastActionChangedTime != nil && [_lastActionLoadTime timeIntervalSinceDate:lastActionChangedTime] > 0){
        return;
    }
    
    GKSummary* sum = [[GKBabySitter inst] getTodaySummary];
    
    self.lblCountFeed.text = [NSString stringWithFormat:@"%d", [sum getCountForAction:GK_E_Action_FEED]];
    self.lblCountSleep.text = [NSString stringWithFormat:@"%d", [sum getCountForAction:GK_E_Action_SLEEP]];
    self.lblCountPlay.text = [NSString stringWithFormat:@"%d", [sum getCountForAction:GK_E_Action_PLAY]];
    self.lblCountDispose.text = [NSString stringWithFormat:@"%d", [sum getCountForAction:GK_E_Action_DISPOSE]];
    
    self.lblTimeFeed.text = [NSString stringWithFormat:@"%d", (int)[sum getTotalSecondsForAction:GK_E_Action_FEED] / 60];
    self.lblTimeSleep.text = [NSString stringWithFormat:@"%d", (int)[sum getTotalSecondsForAction:GK_E_Action_SLEEP] / 60];
    self.lblTimePlay.text = [NSString stringWithFormat:@"%d", (int)[sum getTotalSecondsForAction:GK_E_Action_PLAY] / 60];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
