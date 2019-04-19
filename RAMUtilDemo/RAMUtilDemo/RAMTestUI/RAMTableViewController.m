//
//  RAMTableViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/4/19.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMTableViewController.h"

@interface RAMTableViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RAMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor grayColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}
@end
