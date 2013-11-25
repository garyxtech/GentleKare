//
//  TimeViewController.h
//  HypnoTime
//
//  Created by 薛 洪 on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController
{
    IBOutlet UILabel *timeLabel;
}

-(IBAction)showCurrentTime:(id)sender;

@end
