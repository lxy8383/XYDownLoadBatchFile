//
//  XYDownLoadTool.h
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYDownLoadTool : NSObject

+ (instancetype)sharedInstance;

- (void)downLoadURL:(NSString *)urlStr;


@end

NS_ASSUME_NONNULL_END
