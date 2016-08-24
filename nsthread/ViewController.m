//
//  ViewController.m
//  nsthread
//
//  Created by 丁贵强 on 2016/8/23.
//  Copyright © 2016年 丁贵强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSThread *mainThread = [NSThread mainThread];
    
    NSLog(@"ViewController 主线程 %@",mainThread);
    
    NSLog(@"是否是   主线程 %d",  [NSThread isMainThread]);
    
    NSLog(@"是否是   多线程 %d",   [NSThread isMultiThreaded]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    
    NSThread *curthread = [NSThread currentThread];
    
    NSLog(@"当前线程 %@",curthread);
    
    NSThread *mainThread = [NSThread mainThread];
    
    NSLog(@"主线程 %@",mainThread);
    
    //[self threadCreate3];
    [self test]; // 直接阻塞主线程。
}

- (void)run:(NSString *)para{
    
     NSThread *curthread = [NSThread currentThread];
    
    for (int i = 0; i< 10; ++i) {
        
         NSLog(@" %@ run ----- %@",curthread,para);
    }
    
    
    
    NSLog(@"  after 是否是   多线程 %d",   [NSThread isMultiThreaded]);
}

#pragma mark - Prviate Methods

/**
 *  第一种创建线程的方式
 */
- (void)threadCreate1
{
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object: @"aaa"];
    
    threadA.name = @"线程A";
    
    [threadA start]; // 开启线程A
    
    
    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object: @"bbbb"];
    
    threadB.name = @"线程B";
    
    [threadB start]; // 开启线程B
    
}



/**
 *  第2种创建线程的方式
 */
- (void)threadCreate2
{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"第2种创建线程的方式"];
}



/**
 *  第3种创建线程的方式: 看到没有，没有target:self这个参数。
 */
- (void)threadCreate3
{
    [self performSelectorInBackground:@selector(run:) withObject:@"第3种创建线程的方式"];
}



/**
 *  测试阻塞线程
 */

- (void)test{
    
    NSThread *curthread = [NSThread currentThread];
    
    for (int i = 0; i< 10000; ++i) {
        
        NSLog(@" %@ run ----- %d",curthread,i);
    }

}


@end
