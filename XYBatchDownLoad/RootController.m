//
//  RootController.m
//  XYBatchDownLoad
//
//  Created by liu on 2019/5/22.
//  Copyright © 2019 liu. All rights reserved.
//

#import "RootController.h"
#import "GCDGroupController.h"
#import "GCDSemaphoreController.h"

@interface RootController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation RootController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addUI];
    
}
- (void)addUI{
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.frame;
}
#pragma mark - tableViewDelegate&Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        GCDGroupController *group = [[GCDGroupController alloc]init];
        [self.navigationController pushViewController:group animated:YES];
    }else if(indexPath.row == 1){
        GCDSemaphoreController *semaphore = [[GCDSemaphoreController alloc]init];
        [self.navigationController pushViewController:semaphore animated:YES];
    }else{
        
    }
}

#pragma mark - lazy
- (UITableView *)tableView{
    
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    
    if(!_dataSource){
        _dataSource = [NSMutableArray arrayWithObjects:@"GCD_group",@"GCD_semaphore",@"NSOperation", nil];
    }
    return _dataSource;
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
