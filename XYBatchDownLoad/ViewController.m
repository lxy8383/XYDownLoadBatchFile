//
//  ViewController.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "ViewController.h"
#import "XYDownLoadTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //下载
    [[XYDownLoadTool sharedInstance] downLoadURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp"];
    
    
    //队列下载
    
    
    
    

    
}

@end
