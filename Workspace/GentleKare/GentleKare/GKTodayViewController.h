//
//  GKTodayViewController.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-10.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKTodayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblCountFeed;
@property (weak, nonatomic) IBOutlet UILabel *lblCountPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblCountSleep;
@property (weak, nonatomic) IBOutlet UILabel *lblCountDispose;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeFeed;
@property (weak, nonatomic) IBOutlet UILabel *lblTimePlay;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeSleep;

@end
