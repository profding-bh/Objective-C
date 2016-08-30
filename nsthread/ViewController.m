//
//  ViewController.m
//  nsthread
//
//  Created by 丁贵强 on 2016/8/23.
//  Copyright © 2016年 丁贵强. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import <errno.h>

pthread_t ntid;









@interface ViewController ()

@end

@implementation ViewController



#pragma mark - C 函数
/**
 *  打印id
 *
 *  @param s
 */
void printids(const char *s)
{
    
    pid_t pid;
    pthread_t tid;
    
    pid = getpid();
    tid = pthread_self();
    
    printf("%s pid %u tid %u (0x%x)\n",s,(unsigned int )pid,(unsigned int )tid,
           (unsigned int)tid);
}


void *thr_fn(void *arg){
  //  printids("new thread:"); ios真机，子线程体里面不能再调用自定义函数了。
    

    
    return  ((void *)0);// 子线程直接退出
}



void *fun(void *par){
     // printids("new thread:");
    NSLog(@"=======%@",[NSThread currentThread]);
  
    /*
    pid_t pid;
    pthread_t tid;
    
    pid = getpid();
    tid = pthread_self();
    
    printf("pid %u tid %u (0x%x)\n",(unsigned int )pid,(unsigned int )tid,
           (unsigned int)tid);
     */
    printf("hell\n");
    return NULL;
}




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
    
#if 0
    
    NSThread *curthread = [NSThread currentThread];
    
    NSLog(@"当前线程 %@",curthread);
    
    NSThread *mainThread = [NSThread mainThread];
    
    NSLog(@"主线程 %@",mainThread);
    
    [self threadCreate3];
   // [self test]; // 直接阻塞主线程。
    
    
#endif
    
    
#if 0
    extern    int errno;
    errno = 0; // 在使用之前，先初始化为0
    errno = pthread_create(&ntid,NULL,/*thr_fn*/fun,NULL);
    if(0 != errno){
        printf("can't create thread:%s \n",strerror(errno));
    }
#endif
    
#if 0
    exit(0);  // 进程退出。整个APP直接挂掉。
    
#endif
    
    [NSThread exit];// 直接退出主线程，但整个进程还存在。
    
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
    
    
    // @selector是查找当前类（含子类）的方法。不支持函数
   // [self performSelectorInBackground:@selector(thr_fn) withObject:@"第3种创建线程的方式"];
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
