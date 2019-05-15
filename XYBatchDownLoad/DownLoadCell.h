//
//  DownLoadCell.h
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/14.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol downLoadCellDelegate <NSObject>

- (void)clickDownLoadAction;

@end


@interface DownLoadCell : UITableViewCell


@property (nonatomic, weak) id <downLoadCellDelegate> delegate;
// 进度条
@property (nonatomic, strong) UIProgressView *progress;

// 标题label
@property (nonatomic, strong) UILabel *titleLabel;

// 控制按钮
@property (nonatomic, strong) UIButton *controButton;


@end

NS_ASSUME_NONNULL_END
