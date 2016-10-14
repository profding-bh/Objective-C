

#import "MYViewController.h"
#import <pthread.h>



pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;




@interface MYViewController ()

@property (nonatomic,assign) int leftTicket;

@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



#if 0

/**
 Q:  问题引入：
 *  因为没有对共享资源的访问，进行控制，导致数据紊乱。这在生产环境中是，绝对不允许的。
 正是有了这种需求，必然产生某种机制 来控制。
 */
- (void)saleTicket{
    
    while (true) {
        [NSThread sleepForTimeInterval:1.f];
        
        if (self.leftTicket > 0) {
            self.leftTicket--;
            NSLog(@"%@ 卖出去一张票，剩余:%d",[NSThread currentThread].name, self.leftTicket);
        }else{
            NSLog(@"没有票了");
            return; //结束卖票操作
        }
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.leftTicket = 50;
    
    NSThread* t1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t1.name = @"1号窗口";
    [t1 start];
    
    
    NSThread* t2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t2.name = @"2号窗口";
    [t2 start];
    
    NSThread* t3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t3.name = @"3号窗口";
    [t3 start];
    
    
}

#endif


#if 0

- (void)saleTicket{
    
    NSString *currentThreadStr = [NSThread currentThread].name;
    
    while (true) {
        
        [NSThread sleepForTimeInterval:1.f]; // assume do some other stuffs
        
        pthread_mutex_lock(&mutex);
        
        if (self.leftTicket > 0) {
            self.leftTicket--;
            NSLog(@"%@ 卖出去一张票，剩余:%d",currentThreadStr, self.leftTicket);
        }else {
            
            NSLog(@"%@ 没有票了",currentThreadStr);
            /*
             
             Q: 存在的问题：最后一个执行的线程没有释放锁就，直接返回了。导致不能继续点击输出。
             
             
             */
            return; //结束卖票操作
        }
        
        pthread_mutex_unlock(&mutex);
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.leftTicket = 50;
    
    NSThread* t1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t1.name = @"1号窗口";
    [t1 start];
    
    
    NSThread* t2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t2.name = @"2号窗口";
    [t2 start];
    
    NSThread* t3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t3.name = @"3号窗口";
    [t3 start];
    
}

#endif




- (void)saleTicket{
    
    NSString *currentThreadStr = [NSThread currentThread].name;
    
    while (true) {
        
        [NSThread sleepForTimeInterval:1.f]; // assume do some other stuffs
        
        @synchronized (self) {
            if (self.leftTicket > 0) {
                self.leftTicket--;
                NSLog(@"%@ 卖出去一张票，剩余:%d",currentThreadStr, self.leftTicket);
            }else {
                
                NSLog(@"%@ 没有票了",currentThreadStr);
                /*
                 
                 @synchronized (self) {} 它就没有问题。
                 
                 
                 */
                return; //结束卖票操作
            }
            
        }
        
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.leftTicket = 50;
    
    NSThread* t1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t1.name = @"1号窗口";
    [t1 start];
    
    
    NSThread* t2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t2.name = @"2号窗口";
    [t2 start];
    
    NSThread* t3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    t3.name = @"3号窗口";
    [t3 start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    // purge
    
    pthread_mutex_destroy(&mutex);
    
}

@end
