//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by 薛 洪 on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"


@implementation HypnosisViewController

-(void)loadView{
    CGRect frame = [[UIScreen mainScreen] bounds];
    HypnosisView* v=[[HypnosisView alloc] initWithFrame:frame];
    [self setView:v];
}
@end
