//
//  DispatchClass.h
//  GCD
//
//  Created by ind360 on 12/3/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    PriorityHigh = 2,
    PriorityDefault = 0,
    PriorityLow = -2,
    PriorityBackground = INT16_MIN
}Priority;

@interface DispatchClass : NSObject

/* creates shared object only once. */
+ (id)sharedObject;

/* perform dispatch in Globel concurrent queue asychronously with default dispatch priority. */
- (void)dispatchInBackgroundWithBlock:(void(^)(void))block;

/* perform dispatch in Globel concurrent queue asychronously with default dispatch priority, After that complition block will get executed. completion block will be calle in main queue asychronously. */
- (void)dispatchInBackgroundWithBlock:(void(^)(void))block
                      CompletionBlock:(void(^)(void))complitionBlock;

/* perform block operation in main queue asychronously. */
- (void)dispatchInMainQueue:(void(^)(void))block;


/* perform dispatch in Globel concurrent queue asychronously with Any dispatch priority. */
- (void)dispatchInBackgroundWithPriority:(Priority)aPriority
                                   Block:(void(^)(void))block;

/* perform dispatch in Globel concurrent queue asychronously with Any dispatch priority, After that complition block will get executed. completion block will be calle in main queue asychronously. */
- (void)dispatchInBackgroundWithPriority:(Priority)aPriority
                                   Block:(void(^)(void))block
                         CompletionBlock:(void(^)(void))complitionBlock;
                             
/* perform for loop in Globel concurrent queue asychronously. All loops will get called concurrently so all loop fuction should be independent from each other. */
- (void)dispatchLoopInBackground:(size_t)Numbers
                           Block:(void(^)(size_t))block;

/* perform for loop in serial queue asychronously. */
- (void)dispatchLoopInBackground:(size_t)Numbers
                   InSerialQueue:(dispatch_queue_t)searialQueue
                           Block:(void(^)(size_t))block;

/* perform block operation after specific time in Globel concurrent queue asychronously. */
- (void)dispatchInBackgroundAfter:(float)sec
                        withBlock:(void(^)(void))block;

/* perform block operation after specific time in main queue asychronously. */
- (void)dispatchInMainQueueAfter:(float)sec
                       withBlock:(void(^)(void))block;

/* perform block operation Globel concurrent queue asychronously in specific queue all block given to specific queue will perfom serially. Means tha queue will execute only one block at a time and other blocks will be in queue. */
- (void)dispatchInBackgroundWithSearialQueue:(dispatch_queue_t)searialQueue
                                   WithBlock:(void(^)(void))block;

/* perform block operation main queue asychronously in specific queue all block given to specific queue will perfom serially. Means tha queue will execute only one block at a time and other blocks will be in queue. */
- (void)dispatchInForgroundWithSearialQueue:(dispatch_queue_t)searialQueue
                                  WithBlock:(void(^)(void))block;

@end
