//
//  GCDSemaphoreController.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/22.
//  Copyright © 2019 liu. All rights reserved.
//

#import "GCDSemaphoreController.h"
#import "XYDownLoadTool.h"


/*
 2、信号量主要有3个函数，分别是：
 //创建信号量，参数：信号量的初值，如果小于0则会返回NULL
 dispatch_semaphore_create（信号量值）
 
 //等待降低信号量
 dispatch_semaphore_wait（信号量，等待时间）
 
 //提高信号量
 dispatch_semaphore_signal(信号量)
 */
@interface GCDSemaphoreController ()

@end

@implementation GCDSemaphoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *serialButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [serialButton addTarget:self action:@selector(serialAction:) forControlEvents:UIControlEventTouchUpInside];
//    [serialButton setTitle:@"串行回调" forState:UIControlStateNormal];
//    [serialButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    serialButton.frame = CGRectMake(50, 100, 100, 40);
//    [self.view addSubview:serialButton];
    
    
    UIButton *serialButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [serialButton2 addTarget:self action:@selector(serialAction2:) forControlEvents:UIControlEventTouchUpInside];
    [serialButton2 setTitle:@"串行回调2" forState:UIControlStateNormal];
    [serialButton2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    serialButton2.frame = CGRectMake(50, 140, 100, 40);
    [self.view addSubview:serialButton2];

    
    
    UIButton *serialButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [serialButton3 addTarget:self action:@selector(serialAction3:) forControlEvents:UIControlEventTouchUpInside];
    [serialButton3 setTitle:@"串行回调3" forState:UIControlStateNormal];
    [serialButton3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    serialButton3.frame = CGRectMake(50, 180, 100, 40);
    [self.view addSubview:serialButton3];


}

- (void)serialAction:(UIButton *)sender
{
    [self taskOne];
}

- (void)serialAction2:(UIButton *)sender{
    
    [self taskTwo];
}

- (void)serialAction3:(UIButton *)sender{
    
    [self taskThree];
}
- (void)taskOne
{
    //
    dispatch_queue_t queue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(queue, ^{
        NSLog(@"任务1");
        
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载一的进度%@",progress);
            
        } andCompletion:^(bool success) {
            NSLog(@"1完成");
            
            dispatch_semaphore_signal(semaphore);
        }];

    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(queue, ^{
        NSLog(@"任务2");
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载二的进度%@",progress);
        } andCompletion:^(bool success) {
            NSLog(@"2完成");
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(queue, ^{
        NSLog(@"任务3");
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载三的进度%@",progress);
        } andCompletion:^(bool success) {
            NSLog(@"3完成");
            dispatch_semaphore_signal(semaphore);
        }];
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        NSLog(@"任务4");
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载四的进度%@",progress);
        } andCompletion:^(bool success) {
            NSLog(@"4完成");
            dispatch_semaphore_signal(semaphore);
        }];
    });
}
- (void)taskTwo
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        //@"https://www.apiopen.top/journalismApi"
        [[XYDownLoadTool sharedInstance] requestWithUrl:@"https://www.apiopen.top/journalismApi" andSuccessBlock:^(BOOL success) {
             NSLog(@"1完成");
            dispatch_semaphore_signal(semaphore);
        }];
        
    });
    
    dispatch_group_async(group, queue, ^{
        [[XYDownLoadTool sharedInstance] requestWithUrl:@"https://www.apiopen.top/journalismApi" andSuccessBlock:^(BOOL success) {
            NSLog(@"2完成");
            dispatch_semaphore_signal(semaphore);
        }];

    });
    
    dispatch_group_notify(group, queue, ^{
        //        信号量 -1 为0时wait会阻塞线程
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"信号量为0");
        [[XYDownLoadTool sharedInstance] requestWithUrl:@"https://www.apiopen.top/journalismApi" andSuccessBlock:^(BOOL success) {
            NSLog(@"3完成");
        }];
    });
}
- (void)taskThree
{
    // 串行队列不管是同步还是异步，如果没有信号量控制的话，回调都是无须的。
    dispatch_queue_t queue = dispatch_queue_create("ben", NULL);
    dispatch_async(queue, ^{
        NSLog(@"current1:%@",[NSThread currentThread]);
        dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
        [[XYDownLoadTool sharedInstance] requestWithUrl:@"https://www.apiopen.top/journalismApi" andSuccessBlock:^(BOOL success) {
            NSLog(@"1完成");
            dispatch_semaphore_signal(semaphore);
        }];

        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //等待信号,当信号总量少于0 的时候就会一直等待 ,否则就可以正常的执行,并让信号总量-1
        
        [[XYDownLoadTool sharedInstance] requestWithUrl:@"https://www.apiopen.top/journalismApi" andSuccessBlock:^(BOOL success) {
            NSLog(@"2完成");
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //等待信号,当信号总量少于0 的时候就会一直等待 ,否则就可以正常的执行,并让信号总量-1
        
        [[XYDownLoadTool sharedInstance] requestWithUrl:@"https://www.apiopen.top/journalismApi" andSuccessBlock:^(BOOL success) {
            NSLog(@"3完成");
            dispatch_semaphore_signal(semaphore);
        }];

    });}

- (void)taskFour
{
    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"下载四的进度%@",progress);
    } andCompletion:^(bool success) {
        NSLog(@"4完成");
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
