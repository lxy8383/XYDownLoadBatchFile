//
//  XYDownLoadTool.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "XYDownLoadTool.h"
#import <AFNetworking.h>

@implementation XYDownLoadTool

+ (instancetype)sharedInstance{
    static  id single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[super allocWithZone:nil]init];
    });
    return single;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [XYDownLoadTool sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone{
    
    return [XYDownLoadTool sharedInstance];
    
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    
    return [XYDownLoadTool sharedInstance];
}


- (void)downLoadURL:(NSString *)urlStr
{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //下载地址
    NSURL *downUrl = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:downUrl];
    
    //下载路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [path stringByAppendingPathComponent:@"downLoadVideo"];
    
    NSURLSessionDownloadTask *downTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress %@ , " , downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 设定下载路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"error%@",error);
    }];
    
    [downTask resume];
}
@end
