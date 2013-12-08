//
//  GKButton.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-8.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKButton.h"

@implementation GKButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadStyle];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadStyle];
    }
    return self;
}

-(void) loadStyle{
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
