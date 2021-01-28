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
#import "RAMUtilDemo-Swift.h"

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    [self refreshTableView];
}

- (void)refreshTableView {
    self.staticData = [NSMutableDictionary dictionary];
    
    NSMutableArray<RAMCellData *> *section1 = [NSMutableArray array];
    
    RAMCellModel *exportModel = [[RAMCellModel alloc] initWithTitle:@"__attribute__ 应用实例"
                                                               desc:@"对section部分的配置表信息存储理解实现的一些简单的数据存储提取"];
    exportModel.classStr = @"RAMExportViewController";
    RAMCellData *exportData = RAMCellData.new;
    exportData.cellClass = RAMBaseTableViewCell.class;
    exportData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:exportModel];
    exportData.cellCustomSEL = @selector(cusNormalCell:withData:);
    exportData.cellSelectSEL = @selector(selNormalCellData:);
    exportData.model = exportModel;
    [section1 addObject:exportData];
    
    RAMCellModel *mutalScrollModel = [[RAMCellModel alloc] initWithTitle:@"scrollView的嵌套顺畅上下滑动应用实例"
                                                               desc:@"例如淘宝首页的整体是一个上下滑动view，底下猜你喜欢是支持上下滑动又支持左右滑动的view，做到顺滑衔接滑动"];
    mutalScrollModel.classStr = @"RAMUtilDemo.RAMNestScrollViewController";
    RAMCellData *mutalScrollData = RAMCellData.new;
    mutalScrollData.cellClass = RAMBaseTableViewCell.class;
    mutalScrollData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:mutalScrollModel];
    mutalScrollData.cellCustomSEL = @selector(cusNormalCell:withData:);
    mutalScrollData.cellSelectSEL = @selector(selNormalCellData:);
    mutalScrollData.model = mutalScrollModel;
    [section1 addObject:mutalScrollData];
    
    [self.staticData setObject:section1 forKey:@"工具类"];
    
    
    NSMutableArray<RAMCellData *> *section2 = [NSMutableArray array];
    
    RAMCellModel *codeModel = [[RAMCellModel alloc] initWithTitle:@"代码测试"
                                                            desc:@"任意需要点击操作的代码段测试"];
    codeModel.classStr = @"RAMCodeTestViewController";
    RAMCellData *codeData = RAMCellData.new;
    codeData.cellClass = RAMBaseTableViewCell.class;
    codeData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:codeModel];
    codeData.cellCustomSEL = @selector(cusNormalCell:withData:);
    codeData.cellSelectSEL = @selector(selNormalCellData:);
    codeData.model = codeModel;
    [section2 addObject:codeData];
    
    RAMCellModel *swiftModel = [[RAMCellModel alloc] initWithTitle:@"GraphQL演示"
                                                            desc:@"https://www.apollographql.com/docs/ios/tutorial/tutorial-execute-query/"];
    swiftModel.classStr = @"RAMUtilDemo.RAMSwiftViewController";
    RAMCellData *swiftData = RAMCellData.new;
    swiftData.cellClass = RAMBaseTableViewCell.class;
    swiftData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:swiftModel];
    swiftData.cellCustomSEL = @selector(cusNormalCell:withData:);
    swiftData.cellSelectSEL = @selector(selNormalCellData:);
    swiftData.model = swiftModel;
    [section2 addObject:swiftData];
    
    RAMCellModel *animateModel = [[RAMCellModel alloc] initWithTitle:@"animate学习"
                                                            desc:@""];
    animateModel.classStr = @"RAMUtilDemo.RAMAnimateController";
    RAMCellData *animateData = RAMCellData.new;
    animateData.cellClass = RAMBaseTableViewCell.class;
    animateData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:animateModel];
    animateData.cellCustomSEL = @selector(cusNormalCell:withData:);
    animateData.cellSelectSEL = @selector(selNormalCellData:);
    animateData.model = animateModel;
    [section2 addObject:animateData];
    
    RAMCellModel *tableModel = [[RAMCellModel alloc] initWithTitle:@"tableView滚动测试"
                                                               desc:@"主要对scrollview的delegate的一些研究"];
    tableModel.classStr = @"RAMTableViewController";
    RAMCellData *tableData = RAMCellData.new;
    tableData.cellClass = RAMBaseTableViewCell.class;
    tableData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:tableModel];
    tableData.cellCustomSEL = @selector(cusNormalCell:withData:);
    tableData.cellSelectSEL = @selector(selNormalCellData:);
    tableData.model = tableModel;
    [section2 addObject:tableData];

    RAMCellModel *uiTouchChainModel = [[RAMCellModel alloc] initWithTitle:@"UI响应链测试"
                                                               desc:@"iOS UI事件传递与响应者链\nApplication->Window->last subview->...\npointInside(YES)->遍历子集（无子集hitTest返回本身）\npointInside(NO)->hitTest返回null"];
    uiTouchChainModel.classStr = @"RAMUIEventChainViewController";
    RAMCellData *chainData = RAMCellData.new;
    chainData.cellClass = RAMBaseTableViewCell.class;
    chainData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:uiTouchChainModel];
    chainData.cellCustomSEL = @selector(cusNormalCell:withData:);
    chainData.cellSelectSEL = @selector(selNormalCellData:);
    chainData.model = uiTouchChainModel;
    [section2 addObject:chainData];
    
    RAMCellModel *loadInitializeModel = [[RAMCellModel alloc] initWithTitle:@"load方法和initialize方法的异同"
                                                               desc:@"load不会被覆盖，执行顺序 类 -> 子类 ->分类\ninitialize会被覆盖（分类->子类->类），懒加载(第一次被用到时)"];
    loadInitializeModel.classStr = @"RAMLoadInitializeViewController";
    RAMCellData *loadInitializeData = RAMCellData.new;
    loadInitializeData.cellClass = RAMBaseTableViewCell.class;
    loadInitializeData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:loadInitializeModel];
    loadInitializeData.cellCustomSEL = @selector(cusNormalCell:withData:);
    loadInitializeData.cellSelectSEL = @selector(selNormalCellData:);
    loadInitializeData.model = loadInitializeModel;
    [section2 addObject:loadInitializeData];
    
    RAMCellModel *runtimeModel = [[RAMCellModel alloc] initWithTitle:@"runtime调研"
                                                               desc:@""];
    runtimeModel.classStr = @"RAMRuntimeViewController";
    RAMCellData *runtimeData = RAMCellData.new;
    runtimeData.cellClass = RAMBaseTableViewCell.class;
    runtimeData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:runtimeModel];
    runtimeData.cellCustomSEL = @selector(cusNormalCell:withData:);
    runtimeData.cellSelectSEL = @selector(selNormalCellData:);
    runtimeData.model = runtimeModel;
    [section2 addObject:runtimeData];
    
    RAMCellModel *imageViewModel = [[RAMCellModel alloc] initWithTitle:@"UIImageView的一些调研"
                                                              desc:@"TODO"];
    RAMCellData *imageViewData = RAMCellData.new;
    imageViewData.cellClass = RAMBaseTableViewCell.class;
    imageViewData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:imageViewModel];
    imageViewData.cellCustomSEL = @selector(cusNormalCell:withData:);
    imageViewData.cellSelectSEL = @selector(selNormalCellData:);
    imageViewData.model = imageViewModel;
//    [section2 addObject:imageViewData];
    
    RAMCellModel *nativetojsModel = [[RAMCellModel alloc] initWithTitle:@"native js通信调研"
                                                                  desc:@"主要是jscore的一些应用实践"];
    nativetojsModel.classStr = @"RAMNativeJsViewController";
    RAMCellData *nativetojsData = RAMCellData.new;
    nativetojsData.cellClass = RAMBaseTableViewCell.class;
    nativetojsData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:nativetojsModel];
    nativetojsData.cellCustomSEL = @selector(cusNormalCell:withData:);
    nativetojsData.cellSelectSEL = @selector(selNormalCellData:);
    nativetojsData.model = nativetojsModel;
    [section2 addObject:nativetojsData];
    
    RAMCellModel *tapGestureHackModel = [[RAMCellModel alloc] initWithTitle:@"tap gesture hack的调研"
                                                                   desc:@"为统计全埋的"];
    tapGestureHackModel.classStr = @"RAMTapGestureHackViewController";
    RAMCellData *tapGestureHackData = RAMCellData.new;
    tapGestureHackData.cellClass = RAMBaseTableViewCell.class;
    tapGestureHackData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:tapGestureHackModel];
    tapGestureHackData.cellCustomSEL = @selector(cusNormalCell:withData:);
    tapGestureHackData.cellSelectSEL = @selector(selNormalCellData:);
    tapGestureHackData.model = tapGestureHackModel;
    [section2 addObject:tapGestureHackData];
    
    RAMCellModel *regModel = [[RAMCellModel alloc] initWithTitle:@"正则测试"
                                                            desc:@"正则匹配的一些简单验证"];
    regModel.classStr = @"RAMRegTestViewController";
    RAMCellData *regData = RAMCellData.new;
    regData.cellClass = RAMBaseTableViewCell.class;
    regData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:regModel];
    regData.cellCustomSEL = @selector(cusNormalCell:withData:);
    regData.cellSelectSEL = @selector(selNormalCellData:);
    regData.model = regModel;
    [section2 addObject:regData];
    
    RAMCellModel *wsModel = [[RAMCellModel alloc] initWithTitle:@"weakify(self);strongify(self);"
                                                            desc:@""];
    wsModel.classStr = @"RAMWsViewController";
    RAMCellData *wsData = RAMCellData.new;
    wsData.cellClass = RAMBaseTableViewCell.class;
    wsData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:wsModel];
    wsData.cellCustomSEL = @selector(cusNormalCell:withData:);
    wsData.cellSelectSEL = @selector(selNormalCellData:);
    wsData.model = wsModel;
    [section2 addObject:wsData];
    
    RAMCellModel *defineModel = [[RAMCellModel alloc] initWithTitle:@"宏的使用"
                                                            desc:@"define宏定义中的#，##，@#及/符号"];
    defineModel.classStr = @"RAMMacroViewController";
    RAMCellData *defineData = RAMCellData.new;
    defineData.cellClass = RAMBaseTableViewCell.class;
    defineData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:defineModel];
    defineData.cellCustomSEL = @selector(cusNormalCell:withData:);
    defineData.cellSelectSEL = @selector(selNormalCellData:);
    defineData.model = defineModel;
    [section2 addObject:defineData];
    
    RAMCellModel *blockModel = [[RAMCellModel alloc] initWithTitle:@"Block"
                                                            desc:@"1. block的原理是怎样的？本质是什么？\n"
                                                                  "2. __block的作用是什么？有什么使用注意点？\n"
                                                                  "3. block的属性修饰词为什么是copy？使用block有哪些使用注意？\n"
                                                                  "4. block在修改NSMutableArray，需不需要添加__block？\n"];
    blockModel.classStr = @"RAMBlockViewController";
    RAMCellData *blockData = RAMCellData.new;
    blockData.cellClass = RAMBaseTableViewCell.class;
    blockData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:blockModel];
    blockData.cellCustomSEL = @selector(cusNormalCell:withData:);
    blockData.cellSelectSEL = @selector(selNormalCellData:);
    blockData.model = blockModel;
    [section2 addObject:blockData];
    
    RAMCellModel *gcdModel = [[RAMCellModel alloc] initWithTitle:@"GCD"
                                                            desc:@"1 GCD 栅栏方法：dispatch_barrier_async\n"
                                                                  "2 GCD 延时执行方法：dispatch_after\n"
                                                                  "3 GCD 一次性代码（只执行一次）：dispatch_once\n"
                                                                  "4 GCD 快速迭代方法：dispatch_apply\n"
                                                                  "5 GCD 队列组：dispatch_group\n"
                                                                  "5.1 dispatch_group_notify\n"
                                                                  "5.2 dispatch_group_wait\n"
                                                                  "5.3 dispatch_group_enter、dispatch_group_leave\n"
                                                                  "6 GCD 信号量：dispatch_semaphore\n"
                                                                  "6.1 Dispatch Semaphore 线程同步\n"
                                                                  "6.2 Dispatch Semaphore 线"];
    gcdModel.classStr = @"RAMGCDViewController";
    RAMCellData *gcdData = RAMCellData.new;
    gcdData.cellClass = RAMBaseTableViewCell.class;
    gcdData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:gcdModel];
    gcdData.cellCustomSEL = @selector(cusNormalCell:withData:);
    gcdData.cellSelectSEL = @selector(selNormalCellData:);
    gcdData.model = gcdModel;
    [section2 addObject:gcdData];
    
    RAMCellModel *fbModel = [[RAMCellModel alloc] initWithTitle:@"frame bounds"
                                                            desc:@"frame和bounds的区别"];
    fbModel.classStr = @"RAMFrameBoundsController";
    RAMCellData *fbData = RAMCellData.new;
    fbData.cellClass = RAMBaseTableViewCell.class;
    fbData.cellHeight = [RAMBaseTableViewCell cellHeightWithModel:fbModel];
    fbData.cellCustomSEL = @selector(cusNormalCell:withData:);
    fbData.cellSelectSEL = @selector(selNormalCellData:);
    fbData.model = fbModel;
    [section2 addObject:fbData];
    
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

- (void)selNormalCellData:(RAMCellData *)data {
    RAMCellModel *cellModel = data.didSelModel;
    if (cellModel.classStr.length > 0) {
        Class cl = NSClassFromString(cellModel.classStr);
        UIViewController *vc = [[cl alloc] init];
        if ([vc respondsToSelector:@selector(setTitleText:)]) {
            [vc performSelector:@selector(setTitleText:) withObject:cellModel.title];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
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
