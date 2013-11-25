//
//  ViewController.m
//  Quiz
//
//  Created by 薛 洪 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if(self){
        questions = [[NSMutableArray alloc] init];
        answers = [[NSMutableArray alloc] init];
        
        [questions addObject:@"What is 7 + 7?"];
        [answers addObject:@"14"];
        
        [questions addObject:@"What is the capital of Vermont?"];
        [answers addObject:@"Montpelier"];

        [questions addObject:@"From what is cognac made"];
        [answers addObject:@"Grapes"];
        
    }
    
    return self;
}

-(IBAction)showQuestion:(id)sender{
 
    currentQuestionIndex++;
    
    if(currentQuestionIndex==[questions count]){
        currentQuestionIndex=0;
    }

    NSString *question=[questions objectAtIndex:currentQuestionIndex];
    
    NSLog(@"displaying question: %@", question);
    
    [questionField setText:question];
    
    [answerField setText:@"???"];

}

-(IBAction)showAnswer:(id)sender{
    NSString *answer=[answers objectAtIndex:currentQuestionIndex];
    
    [answerField setText:answer];
}

@end
