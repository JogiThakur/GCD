//
//  DispatchClass.m
//  GCD
//
//  Created by ind360 on 12/3/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import "DispatchClass.h"

static DispatchClass *_sharedObj;

@implementation DispatchClass


+ (id)sharedObject
{
    
    if(!_sharedObj)
     _sharedObj = [[self alloc]init];
    return _sharedObj;
}

- (void)dispatchInBackgroundWithBlock:(void(^)(void))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)dispatchInBackgroundWithBlock:(void(^)(void))block
                      CompletionBlock:(void (^)(void))complitionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ block();
    dispatch_async(dispatch_get_main_queue(), ^{ complitionBlock(); }); });
}

- (void)dispatchInMainQueue:(void(^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)dispatchInBackgroundWithPriority:(Priority)aPriority
                                   Block:(void(^)(void))block;
{
    dispatch_async(dispatch_get_global_queue(aPriority, 0), block);
}

- (void)dispatchInBackgroundWithPriority:(Priority)aPriority
                                   Block:(void(^)(void))block
                         CompletionBlock:(void(^)(void))complitionBlock;
{
    dispatch_async(dispatch_get_global_queue(aPriority, 0), ^{ block();
        dispatch_async(dispatch_get_main_queue(), ^{ complitionBlock(); }); });
}

- (void)dispatchLoopInBackground:(size_t)Numbers
                           Block:(void(^)(size_t))block;
{
    dispatch_apply(Numbers, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)dispatchLoopInBackground:(size_t)Numbers
                   InSerialQueue:(dispatch_queue_t)searialQueue
                           Block:(void(^)(size_t))block;
{
   dispatch_apply(Numbers, searialQueue, block);
}

- (void)dispatchInBackgroundAfter:(float)sec
                        withBlock:(void(^)(void))block
{
    int64_t delayInSeconds = sec;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);
}

- (void)dispatchInMainQueueAfter:(float)sec
                       withBlock:(void(^)(void))block
{
    int64_t delayInSeconds = sec;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(),block);
}

- (void)dispatchInBackgroundWithSearialQueue:(dispatch_queue_t)searialQueue
                                   WithBlock:(void(^)(void))block
{
    dispatch_async(searialQueue, block);
}

- (void)dispatchInForgroundWithSearialQueue:(dispatch_queue_t)searialQueue
                                  WithBlock:(void(^)(void))block
{
   dispatch_sync(searialQueue, block); 
}


@end
