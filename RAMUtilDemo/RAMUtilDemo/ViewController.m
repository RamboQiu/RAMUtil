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
#import <RAMUtil/RAMMustOverrider.h>
#import "RAMBaseTableViewCell.h"
#import "RAMExportViewController.h"

@interface ViewController () <
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<RAMCellData *> *> *staticData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAMUtil";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self refreshTableView];
}

- (void)refreshTableView {
    self.staticData = [NSMutableArray array];
    
    NSMutableArray<RAMCellData *> *section1 = [NSMutableArray array];
    
    RAMCellModel *exportModel = [[RAMCellModel alloc] initWithTitle:@"__attribute__ 应用实例"
                                                               desc:@"对section部分的配置表信息存储理解实现的一些简单的数据存储提取"];
    RAMCellData *exportData = RAMCellData.new;
    exportData.cellClass = RAMBaseTableViewCell.class;
    exportData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:exportModel];
    exportData.cellCustomSEL = @selector(cusExportCell:withData:);
    exportData.cellSelectSEL = @selector(selExportCellData:);
    exportData.model = exportModel;
    [section1 addObject:exportData];
    
    [self.staticData addObject:section1];
    
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)cusExportCell:(RAMBaseTableViewCell *)cell withData:(RAMCellData *)data{
    cell.model = data.model;
}


- (void)selExportCellData:(RAMCellData *)data {
    RAMExportViewController *vc = [[RAMExportViewController alloc] init];
    RAMCellModel *cellModel = data.didSelModel;
    vc.titleText = cellModel.title;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -

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
        [self performSelector:data.cellSelectSEL withObject:data];
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
