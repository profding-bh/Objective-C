//
//  myNsthread.h
//  nsthread
//
//  Created by 丁贵强 on 2016/8/23.
//  Copyright © 2016年 丁贵强. All rights reserved.
//

#ifndef myNsthread_h
#define myNsthread_h


00:15—00：42

/*
 
 在iOS开发中，创建一个NSThread类的实例，作为一个线程。
 一个线程就是一个NSThread对象。
 
 使用NSThread创建线程有3方法。
 */

/*	NSThread.h
	Copyright (c) 1994-2015, Apple Inc. All rights reserved.
 */

#import <Foundation/NSObject.h>
#import <Foundation/NSDate.h>

@class NSArray<ObjectType>, NSMutableDictionary, NSDate, NSNumber, NSString;

NS_ASSUME_NONNULL_BEGIN

@interface NSThread : NSObject  {
@private
    id _private;
    uint8_t _bytes[44];
}

// 获取当前线程
+ (NSThread *)currentThread;

// 1）创建线程后，自动启动线程。
+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(nullable id)argument;



+ (BOOL)isMultiThreaded;

@property (readonly, retain) NSMutableDictionary *threadDictionary;

+ (void)sleepUntilDate:(NSDate *)date;
+ (void)sleepForTimeInterval:(NSTimeInterval)ti;


/**
 *  终止正在执行的线程，可以是主线程。但整个进程不会退出。
 */
+ (void)exit;

+ (double)threadPriority;
+ (BOOL)setThreadPriority:(double)p;

@property double threadPriority NS_AVAILABLE(10_6, 4_0); // To be deprecated; use qualityOfService below

@property NSQualityOfService qualityOfService NS_AVAILABLE(10_10, 8_0); // read-only after the thread is started

+ (NSArray<NSNumber *> *)callStackReturnAddresses NS_AVAILABLE(10_5, 2_0);
+ (NSArray<NSString *> *)callStackSymbols NS_AVAILABLE(10_6, 4_0);

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@property NSUInteger stackSize NS_AVAILABLE(10_5, 2_0);


// 从这里可以知道 属性 可以和 方法 同名。

@property (readonly) BOOL isMainThread NS_AVAILABLE(10_5, 2_0);
+ (BOOL)isMainThread NS_AVAILABLE(10_5, 2_0); // reports whether current thread is main
// 获得主线程。
+ (NSThread *)mainThread NS_AVAILABLE(10_5, 2_0);



- (instancetype)init NS_AVAILABLE(10_5, 2_0) NS_DESIGNATED_INITIALIZER;

// 2) 创建新的线程，必须调用start方法启动线程,否则线程体是不会执行的。
- (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(nullable id)argument NS_AVAILABLE(10_5, 2_0);





@property (readonly, getter=isExecuting) BOOL executing NS_AVAILABLE(10_5, 2_0);
@property (readonly, getter=isFinished) BOOL finished NS_AVAILABLE(10_5, 2_0);
@property (readonly, getter=isCancelled) BOOL cancelled NS_AVAILABLE(10_5, 2_0);

- (void)cancel NS_AVAILABLE(10_5, 2_0);

- (void)start NS_AVAILABLE(10_5, 2_0);

- (void)main NS_AVAILABLE(10_5, 2_0);	// thread body method

@end

FOUNDATION_EXPORT NSString * const NSWillBecomeMultiThreadedNotification;
FOUNDATION_EXPORT NSString * const NSDidBecomeSingleThreadedNotification;
FOUNDATION_EXPORT NSString * const NSThreadWillExitNotification;

@interface NSObject (NSThreadPerformAdditions)

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array;


- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait;
// equivalent to the first method with kCFRunLoopCommonModes

- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array NS_AVAILABLE(10_5, 2_0);


- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait NS_AVAILABLE(10_5, 2_0);


// equivalent to the first method with kCFRunLoopCommonModes
// 3) 隐式创建线程，在后台创建线程。
- (void)performSelectorInBackground:(SEL)aSelector withObject:(nullable id)arg NS_AVAILABLE(10_5, 2_0);

@end

NS_ASSUME_NONNULL_END




#endif /* myNsthread_h */
