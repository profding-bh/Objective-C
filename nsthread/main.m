//
//  main.m
//  nsthread
//
//  Created by 丁贵强 on 2016/8/23.
//  Copyright © 2016年 丁贵强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSThread *mainThread = [NSThread mainThread];
        
        NSLog(@"main 主线程 %@",mainThread);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
