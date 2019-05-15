//
//  DownLoadCell.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/14.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DownLoadCell.h"

@implementation DownLoadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
//    [self.contentView addSubview:self.progress];
    
    [self.contentView addSubview:self.controButton];
    
    [self.contentView addSubview:self.titleLabel];
    
    
    self.controButton.frame = CGRectMake(20, 5, 40, 40);
    
    self.titleLabel.frame = CGRectMake(100, 5, 100, 20);
}

- (void)doControllAction:(UIButton *)sender
{
    
}

#pragma mark - lazy
- (UIButton *)controButton
{
    if(!_controButton){
        _controButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_controButton addTarget:self action:@selector(doControllAction:) forControlEvents:UIControlEventTouchUpInside];
        _controButton.backgroundColor = [UIColor redColor];
        [_controButton setTitle:@"下" forState:UIControlStateNormal];
        _controButton.backgroundColor = [UIColor yellowColor];
    }
    return _controButton;
}
- (UIProgressView *)progress
{
    if(!_progress){
        _progress = [[UIProgressView alloc]init];
    }
    return _progress;
}
- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
