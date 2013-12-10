//
//  GKOverviewViewController.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKOverviewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *babyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgBaby;
@property (weak, nonatomic) IBOutlet UIButton *btnFeed;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnSleep;
@property (weak, nonatomic) IBOutlet UIButton *btnDispose;
- (IBAction)triggerDispose:(id)sender;

@end
