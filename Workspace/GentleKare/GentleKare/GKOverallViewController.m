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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(GKActionStartViewController*) vcActionStart{
    if(_vcActionStart==nil){
        _vcActionStart = [self.storyboard instantiateViewControllerWithIdentifier:@"VC_ACTION_START"];
    }
    return _vcActionStart;
}

-(void)onTriggerFeeding:(id)sender{
    [[self vcActionStart] loadAction:GK_E_Action_FEED isStart:true];
    [self performSegueWithIdentifier:@"SG_ACTION_START" sender:self];
}



@end
