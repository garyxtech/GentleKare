//
//  HPAppDelegate.m
//  Hyponosister
//
//  Created by 薛 洪 on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HPAppDelegate.h"
#import "HPHyponosisView.h"

@implementation HPAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    CGRect screenRect = [[self window] bounds];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [[self window] addSubview:scrollView];
    
    
    CGRect bigRect = screenRect;
    //bigRect.size.width *= 2.0;
    view = [[HPHyponosisView alloc] initWithFrame:screenRect];
    [view setBackgroundColor:[UIColor redColor]];
    [scrollView addSubview:view];
    
    //screenRect.origin.x = screenRect.size.width;
    //HPHyponosisView *anotherView = [[HPHyponosisView alloc]initWithFrame:screenRect];
    //[scrollView addSubview:anotherView];
    
    
    [scrollView setContentSize:bigRect.size];
    
    //[scrollView setPagingEnabled:YES];
    [scrollView setMinimumZoomScale:0.1];
    [scrollView setMaximumZoomScale:5.0];
    [scrollView setDelegate:self];
    
    BOOL successBecameFirstResponder = [view becomeFirstResponder];
    if(successBecameFirstResponder){
        NSLog(@"Did become first responder");
    }else{
        NSLog(@"Failed become first responder");
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    return YES;
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return view;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
