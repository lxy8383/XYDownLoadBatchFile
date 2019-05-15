//
//  ViewController.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "ViewController.h"
#import "XYDownLoadTool.h"
#import "DownLoadCell.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sourceArr;

@property (nonatomic, strong) NSOperationQueue *queue;

//
@property (nonatomic, strong) NSInvocationOperation * op1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 串行
    UIButton *serialButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [serialButton addTarget:self action:@selector(serialAction:) forControlEvents:UIControlEventTouchUpInside];
    [serialButton setTitle:@"串行" forState:UIControlStateNormal];
    [serialButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    serialButton.frame = CGRectMake(50, 50, 50, 40);
    [self.view addSubview:serialButton];
    
    // 并发
    UIButton *concurrentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [concurrentButton addTarget:self action:@selector(concurrentAction:) forControlEvents:UIControlEventTouchUpInside];
    [concurrentButton setTitle:@"并发" forState:UIControlStateNormal];
    [concurrentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    concurrentButton.frame = CGRectMake(130, 50, 50, 40);
    [self.view addSubview:concurrentButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"暂停" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(200, 50, 50, 40);
    [self.view addSubview:cancelButton];


    
    self.sourceArr = [NSMutableArray arrayWithObjects:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp",@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp", nil];
    
    [self setUpUI];
    
    //下载
//    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp"];
    
}


- (void)setUpUI
{
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 150, self.view.frame.size.width, 300);
}

- (void)serialAction:(UIButton *)sender
{
    self.queue = [[NSOperationQueue alloc]init];
    self.op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(taskOne) object:nil];
//    NSInvocationOperation * op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(taskTwo) object:nil];
//    NSInvocationOperation * op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(taskThree) object:nil];
//    NSInvocationOperation * op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(taskFour) object:nil];
    
    self.queue.maxConcurrentOperationCount = 1;
    [self.queue addOperation:self.op1];
//    [self.queue addOperation:op2];
//    [self.queue addOperation:op3];
//    [self.queue addOperation:op4];
    
}

- (void)cancelAction:(UIButton *)sender
{
    //调用操作暂停
    [self.op1 cancel];
}

- (void)concurrentAction:(UIButton*)sender
{
    
}


- (void)taskOne
{
    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"下载一的进度%@",progress);
    } andCompletion:^(bool success) {
        NSLog(@"1完成");
    }];
}
- (void)taskTwo
{
    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"下载二的进度%@",progress);
    } andCompletion:^(bool success) {
        NSLog(@"2完成");
    }];
}
- (void)taskThree
{
    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"下载三的进度%@",progress);
    } andCompletion:^(bool success) {
        NSLog(@"3完成");
    }];
}

- (void)taskFour
{
    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp" andProgressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"下载四的进度%@",progress);
    } andCompletion:^(bool success) {
        NSLog(@"4完成");
    }];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    DownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[DownLoadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


#pragma mark - lazy
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)sourceArr
{
    if(!_sourceArr){
        _sourceArr = [[NSMutableArray alloc]init];
    }
    return _sourceArr;
}
@end
