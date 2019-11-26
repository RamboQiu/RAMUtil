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
#import "RAMTableViewController.h"
#import "RAMUIEventChainViewController.h"

@interface ViewController () <
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary<NSString * ,NSMutableArray<RAMCellData *> *> *staticData;
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
    self.staticData = [NSMutableDictionary dictionary];
    
    NSMutableArray<RAMCellData *> *section1 = [NSMutableArray array];
    
    RAMCellModel *exportModel = [[RAMCellModel alloc] initWithTitle:@"__attribute__ 应用实例"
                                                               desc:@"对section部分的配置表信息存储理解实现的一些简单的数据存储提取"];
    RAMCellData *exportData = RAMCellData.new;
    exportData.cellClass = RAMBaseTableViewCell.class;
    exportData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:exportModel];
    exportData.cellCustomSEL = @selector(cusNormalCell:withData:);
    exportData.cellSelectSEL = @selector(selExportCellData:);
    exportData.model = exportModel;
    [section1 addObject:exportData];
    
    [self.staticData setObject:section1 forKey:@"工具类"];
    
    
    NSMutableArray<RAMCellData *> *section2 = [NSMutableArray array];
    
    RAMCellModel *tableModel = [[RAMCellModel alloc] initWithTitle:@"tableView滚动测试"
                                                               desc:@"主要对scrollview的delegate的一些研究"];
    RAMCellData *tableData = RAMCellData.new;
    tableData.cellClass = RAMBaseTableViewCell.class;
    tableData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:tableModel];
    tableData.cellCustomSEL = @selector(cusNormalCell:withData:);
    tableData.cellSelectSEL = @selector(selTableCellData:);
    tableData.model = tableModel;
    [section2 addObject:tableData];
    
    RAMCellModel *uiTouchChainModel = [[RAMCellModel alloc] initWithTitle:@"UI响应链测试"
                                                               desc:@"iOS UI事件传递与响应者链"];
    RAMCellData *chainData = RAMCellData.new;
    chainData.cellClass = RAMBaseTableViewCell.class;
    chainData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:tableModel];
    chainData.cellCustomSEL = @selector(cusNormalCell:withData:);
    chainData.cellSelectSEL = @selector(selChainCellData:);
    chainData.model = uiTouchChainModel;
    [section2 addObject:chainData];
    
    [self.staticData setObject:section2 forKey:@"测试类"];
    
    
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
- (void)cusNormalCell:(RAMBaseTableViewCell *)cell withData:(RAMCellData *)data{
    cell.model = data.model;
}

- (void)selExportCellData:(RAMCellData *)data {
    RAMExportViewController *vc = [[RAMExportViewController alloc] init];
    RAMCellModel *cellModel = data.didSelModel;
    vc.titleText = cellModel.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selTableCellData:(RAMCellData *)data {
    RAMTableViewController *vc = [[RAMTableViewController alloc] init];
    RAMCellModel *cellModel = data.didSelModel;
    vc.titleText = cellModel.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selChainCellData:(RAMCellData *)data {
    RAMUIEventChainViewController *vc = [[RAMUIEventChainViewController alloc] init];
    RAMCellModel *cellModel = data.didSelModel;
    vc.titleText = cellModel.title;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -

- (NSMutableArray<RAMCellData *> *)sectiondataAtSection:(NSInteger)section {
    NSString *key = [self.staticData.allKeys at:section];
    return [self.staticData objectForKey:key];
}

- (RAMCellData *)rowDataAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray<RAMCellData *> *sectionData = [self sectiondataAtSection:indexPath.section];
    RAMCellData *rowData = [sectionData at:indexPath.row];
    return rowData;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.staticData.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self sectiondataAtSection:section].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RAMCellData *data = [self rowDataAtIndexPath:indexPath];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (data.cellSelectSEL)
        [self performSelector:data.cellSelectSEL withObject:data];
#pragma clang diagnostic pop
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RAMCellData *data = [self rowDataAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:data.cellIdentifier];
    if (!cell) {
        cell = [[data.cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:data.cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (data.cellCustomSEL) {
        [self performSelector:data.cellCustomSEL withObject:cell withObject:data];
    }
#pragma clang diagnostic pop
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    RAMCellData *data = [[self sectiondataAtSection:section] at:0];
    if (data.sectionFooterHeight > 0)
        return data.sectionFooterHeight;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RAMCellData *data = [self rowDataAtIndexPath:indexPath];
    if (data.cellHeight > 0)
        return data.cellHeight;
    return 54;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.staticData allKeys] at:section];
}

@end
