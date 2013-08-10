//
//  ViewController.m
//  GCD
//
//  Created by ind360 on 12/3/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import "ViewController.h"
#import "DispatchClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[DispatchClass sharedObject] dispatchInBackgroundAfter:3.0 withBlock:^{
        NSLog(@"dispatching block after some time in background.");
    }];
    
    [[DispatchClass sharedObject] dispatchInMainQueueAfter:2.0 withBlock:^{
        NSLog(@"dispatching block after some time in main thread.");
    }];
    
    [[DispatchClass sharedObject] dispatchInForgroundWithSearialQueue:dispatch_queue_create("com.GCD.forground", NULL) WithBlock:^{
        NSLog(@"syc operation in serial queue.");
    }];
    
    [[DispatchClass sharedObject] dispatchInBackgroundWithBlock:^{
        NSLog(@"background Operation.");
    }];
    
    [[DispatchClass sharedObject] dispatchInMainQueue:^{
        NSLog(@"dispatching in main queue.");
    }];
    
    [[DispatchClass sharedObject] dispatchInBackgroundWithPriority:PriorityBackground Block:^{
        NSLog(@"background operation with low priority.");
    }];
    
    [[DispatchClass sharedObject] dispatchInBackgroundWithPriority:PriorityHigh Block:^{
        NSLog(@"high priority operation in background");
    } CompletionBlock:^{
        NSLog(@"with completion bock");
    }];
    
    [[DispatchClass sharedObject] dispatchInBackgroundWithSearialQueue:dispatch_queue_create("com.GCD.background", NULL) WithBlock:^{
        NSLog(@"asyc operation in serial queue.");
    }];
    
    [[DispatchClass sharedObject] dispatchLoopInBackground:5 Block:^(size_t count) {
        NSLog(@"%ld", count);
    }];
    
    [[DispatchClass sharedObject] dispatchLoopInBackground:15 InSerialQueue:dispatch_queue_create("com.GCD.loop", NULL) Block:^(size_t count) {
        NSLog(@"%ld", count);
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
