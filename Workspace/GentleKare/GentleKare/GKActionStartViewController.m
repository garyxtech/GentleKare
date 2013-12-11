//
//  GKActionStartViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKActionStartViewController.h"

@interface GKActionStartViewController ()

@end

@implementation GKActionStartViewController{
    GK_E_Action _actionType;
    NSDate* _startTime;
    NSTimer* _timerElapsedTime;
}

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
    
    [self updateElapseTime];
    
    if(_timerElapsedTime!=nil){
        [_timerElapsedTime invalidate];
    }
    
    _timerElapsedTime = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateElapseTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timerElapsedTime forMode:NSRunLoopCommonModes];
    
    NSString* actionDesc = [[GKBabySitter inst] getActionDescription:_actionType];
    self.lblAction.text = actionDesc;
    self.lblStartTime.text = [GKUtil dateToStr:_startTime];
    
}

-(void)updateElapseTime{
    NSDate* now = [NSDate date];
    NSTimeInterval elapseSeconds = [now timeIntervalSinceDate:_startTime];
    self.lblElapsedTime.text = [NSString stringWithFormat:@"%d分%d秒", (int)elapseSeconds/60, (int)elapseSeconds%60];
    
}

-(void)loadForAction:(GK_E_Action)action{
    _actionType = action;
    _startTime = [NSDate date];
    [[GKBabySitter inst] action:action at:_startTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)endAction:(id)sender {
    [[GKBabySitter inst] finishAt:[NSDate date]];
    [[self navigationController] popViewControllerAnimated:true];
}

- (IBAction)cancelAction:(id)sender {
    [[self navigationController] popViewControllerAnimated:true];
}

- (IBAction)triggerDispose:(id)sender {
    [[GKBabySitter inst] disposeNow];
}
@end
