//
//  HPHyponosisView.m
//  Hyponosister
//
//  Created by 薛 洪 on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HPHyponosisView.h"

@implementation HPHyponosisView

@synthesize circleColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setCircleColor:[UIColor whiteColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds= [self bounds];
    CGPoint center;
    center.x=bounds.origin.x + bounds.size.width/2.0;
    center.y=bounds.origin.y + bounds.size.height/2.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height)/4.0;
    
    CGContextSetLineWidth(ctx, 10);    
    [[self circleColor]setStroke];
    
    CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
    
    CGContextStrokePath(ctx);
}

-(BOOL) canBecomeFirstResponder{
    return YES;
}

-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motion began");
    [self setCircleColor:[UIColor greenColor]];                    
}

-(void) setCircleColor:(UIColor *)newColor{
    circleColor = newColor;
    [self setNeedsDisplay];
}

@end
