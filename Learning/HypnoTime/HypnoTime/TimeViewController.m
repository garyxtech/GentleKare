//
//  TimeViewController.m
//  HypnoTime
//
//  Created by 薛 洪 on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeViewController.h"

@implementation TimeViewController

-(IBAction)showCurrentTime:(id)sender{
    NSDate *now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    timeLabel.text = [formatter stringFromDate:now];
}

@end
