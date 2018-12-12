//
//  ViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/12.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "ViewController.h"
#import <RAMUtil/RAMCellData.h>
#import <RAMUtil/RAMSafeCollection.h>

@interface ViewController () <
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<RAMCellData *> *> *staticData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
}

- (void)refreshTableView {
    self.staticData = [NSMutableArray array];
    
    NSMutableArray<RAMCellData *> *section1 = [NSMutableArray array];
    
    RAMCellData *cellData = RAMCellData.new;
    
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.bounds = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.staticData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.staticData at:section].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RAMCellData *data = [[self.staticData at:indexPath.section] at:indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (data.cellSelectSEL)
        [self performSelector:data.cellSelectSEL withObject:indexPath withObject:data];
#pragma clang diagnostic pop
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RAMCellData *data = [[self.staticData at:indexPath.section] at:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:data.cellIdentifier];
    if (!cell) {
        cell = [[data.cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:data.cellIdentifier];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (data.cellCustomSEL) {
        [self performSelector:data.cellCustomSEL withObject:cell withObject:data];
    }
#pragma clang diagnostic pop
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    RAMCellData *data = [[self.staticData at:section] at:0];
    if (data.sectionFooterHeight > 0)
        return data.sectionFooterHeight;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RAMCellData *data = [[self.staticData at:indexPath.section] at:indexPath.row];
    if (data.cellHeight > 0)
        return data.cellHeight;
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    RAMCellData *data = [[self.staticData at:section] at:0];
    if (data.sectionHeaderHeight > 0)
        return data.sectionHeaderHeight;
    return CGFLOAT_MIN;
}


@end
