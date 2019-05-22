//
//  GCDGroupController.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/22.
//  Copyright © 2019 liu. All rights reserved.
//

#import "GCDGroupController.h"
#import "XYDownLoadTool.h"

@interface GCDGroupController ()

@end

@implementation GCDGroupController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *serialButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [serialButton addTarget:self action:@selector(serialAction:) forControlEvents:UIControlEventTouchUpInside];
    [serialButton setTitle:@"start" forState:UIControlStateNormal];
    [serialButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    serialButton.frame = CGRectMake(50, 100, 50, 40);
    [self.view addSubview:serialButton];

    
}

- (void)serialAction:(UIButton *)sender{
    
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"异步调用1");
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载一的进度%@",progress);
        } andCompletion:^(bool success) {
            NSLog(@"1完成");
        }];

        //任务完成后通知组：任务离开
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"异步调用2");
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载二的进度%@",progress);
        } andCompletion:^(bool success) {
            NSLog(@"2完成");
        }];

        //任务完成后通知组：任务离开
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"异步调用3");
        [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
            NSLog(@"下载三的进度%@",progress);
        } andCompletion:^(bool success) {
            NSLog(@"3完成");
        }];

        //任务完成后通知组：任务离开
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@" dispatch_group_notify 主队列完毕 ***************************** ");
            
        });
        
    });

}
/*
 REAM ME
 很显然这个添加到组里面是异步调用方法（只是调用顺序），但是回调是不能做到同步。
 如果想要实现同步结果，就需要异步调用方法中实现同步
 那么想要实现异步回调而不用通知或者block嵌套block 可以用后面的方法
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
