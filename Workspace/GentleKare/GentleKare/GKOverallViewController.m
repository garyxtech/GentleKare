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
    NSLog(@"%@", view);
    
    _actionEndController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC_ACTION_END"];
    view = _actionEndController.view;
    NSLog(@"%@", view);
    
    view = nil;
    
    [self loadBabyData];
}

-(void) loadBabyData{
    [_lblBabyName setText:[GKBabySitter baby].name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTriggerFeeding:(id)sender{
    if([GKBabySitter isLastActionInProgress]){
        [_actionEndController resetData];
        [self presentViewController:_actionEndController animated:true completion:nil];
    }else{
        [_actionStartController loadAction:GK_E_Action_FEED];
        [self presentViewController:_actionStartController animated:true completion:nil];
    }
}

@end
