//
//  GKOverviewViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKOverviewViewController.h"
#import "GKActionStartViewController.h"
#import "GKBabyDetailViewController.h"

@interface GKOverviewViewController ()

@end

@implementation GKOverviewViewController{
    NSDate* _lastLoadTime;
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
    
    NSDate* lastChangedTime = [[GKBabySitter inst] getLastBabyDetailChangedTime];
    if(_lastLoadTime != nil && lastChangedTime != nil && [_lastLoadTime timeIntervalSinceDate:lastChangedTime] > 0){
        return;
    }
    
    self.navigationItem.title = [[GKBabySitter inst] baby].name;
    UIImage* image = [UIImage imageWithData:[[GKBabySitter inst] baby].image];
    self.imgBaby.image = image;
    _lastLoadTime = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSString *sgID = segue.identifier;
    
    GK_E_Action actionType = GK_E_Action_IDLE;
    if([sgID isEqualToString:@"SG_MAIN_FEED"]){
        actionType = GK_E_Action_FEED;
    }else if([sgID isEqualToString:@"SG_MAIN_PLAY"]){
        actionType = GK_E_Action_PLAY;
    }else if([sgID isEqualToString:@"SG_MAIN_SLEEP"]){
        actionType = GK_E_Action_SLEEP;
    }
    
    if([[segue destinationViewController] class] == [GKActionStartViewController class]){
        [((GKActionStartViewController*)[segue destinationViewController]) loadForAction:actionType];
    }
    
    if([[segue destinationViewController] class] == [GKBabyDetailViewController class]){
        [((GKBabyDetailViewController*)[segue destinationViewController]) loadBabyDetail:[[GKBabySitter inst] baby]];
    }
}

- (IBAction)triggerDispose:(id)sender {
    [[GKBabySitter inst] disposeNow];
}
@end
