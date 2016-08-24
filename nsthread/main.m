//
//  main.m
//  nsthread
//
//  Created by  on 2016/8/23.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSThread *mainThread = [NSThread mainThread];
        
        NSLog(@"main 主线程 %@",mainThread);
        
        NSThread *curthread = [NSThread currentThread];
        
        NSLog(@"main() 当前线程 %@",curthread);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
