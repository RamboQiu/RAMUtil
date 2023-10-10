//
//  RAMSwitchCollectionView.swift
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2023/10/9.
//  Copyright © 2023 裘俊云. All rights reserved.
//

import UIKit

class RAMWaterflowLayout: UICollectionViewLayout {
    
    /// 行高(水平瀑布流时),默认为100
    var rowHeight: CGFloat = 50.0
    /// 单元格宽度(垂直瀑布流时)
//    var itemWidth = 100.0
    /// 列数 : 默认为3
    var numberOfColumns = 3

    /// 内边距 : 每一列之间的间距 (top, left, bottom, right)默认为{10, 10, 10, 10};
    var insets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)

    /// 每一行之间的间距 : 默认为10
    var rowGap: CGFloat = 10.0

    /// 每一列之间的间距 : 默认为10
    var columnGap: CGFloat = 10.0

    /// 高度数组 : 存储所有item的高度
    var itemHeights = [CGFloat]()

    /// 宽度数组 : 存储所有item的宽度
    var itemWidths = [CGFloat]()

    /// 瀑布流类型 : 分为水平瀑布流 1 和 垂直瀑布流 0
    var type = 0
    
    
    
    var itemAttributes = [UICollectionViewLayoutAttributes]() // 存放每个cell的布局属性

    // 垂直瀑布流相关属性
    var columnsHeights = [CGFloat]() // 每一列的高度(count=多少列)
    var maxHeight: CGFloat { // 最长列的高度(最大高度)
        return columnsHeights[maxIndex]
    }
    var minHeight: CGFloat { // 最短列的高度(最低高度)
        return columnsHeights[minIndex]
    }
    var minIndex: Int { // 最短列的下标
        var minIndex = 0
        var minHeight = CGFloat(MAXFLOAT)
        for i in 0..<numberOfColumns {
            let currentHeight = columnsHeights[i]
            if (currentHeight < minHeight) {
                minHeight = currentHeight;
                minIndex = i;
            }
        }
        return minIndex;
    }
    var maxIndex: Int { // 最长列的下标
        var maxIndex = 0
        var maxHeight: CGFloat = 0.0
        for i in 0..<numberOfColumns {
            let currentHeight = columnsHeights[i]
            if (currentHeight > maxHeight) {
                maxHeight = currentHeight;
                maxIndex = i;
            }
        }
        return maxIndex;
    }

    // 水平瀑布流相关属性
    var columnsWidths  = [CGFloat]() // 每一行的宽度(count不确定)
    var tempItemX = 0.0 // 临时x : 用来计算每个cell的x值
    var maxRowIndex = 0.0 //最大行
    
    
    var itemWidth: CGFloat {
        let clvWidth = collectionView?.frame.size.width ?? 0.0
        let totalW = clvWidth - CGFloat((numberOfColumns + 1)) * columnGap
        return totalW / CGFloat(numberOfColumns)
    }
    
    override func prepare() {
        super.prepare()
        if type == 1 {
            maxRowIndex = 0
        }
        
        if type == 0 {
            columnsHeights.removeAll()
            for _ in 0..<numberOfColumns {
                columnsHeights.append(insets.top)
            }
        }
        
        itemAttributes.removeAll()
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        tempItemX = insets.left
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            if type == 0 {
                setVerticalFrame(indexPath: indexPath)
            } else if type == 1 {
                setHorizontalFrame(indexPath: indexPath)
            }
        }
    }
    /**
     *  水平瀑布：设置每一个attrs的frame，并加入数组中
     */
    func setHorizontalFrame(indexPath: IndexPath) {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let w = itemWidths[indexPath.item]
        let width = w + columnGap
        let h = (rowHeight == 0) ? 100 : rowHeight
        
        
        /**
         *  如果当前的x值+当前cell的宽度 超出了 屏幕宽度，那么就要换行了。
         *  换行操作 : 最大行+1，tempItemX重置为10(self.insets.left)。
         */
        if tempItemX + w > UIScreen.main.bounds.size.width {
            maxRowIndex += 1
            tempItemX = insets.left
        }
        
        let x = tempItemX
        let y = insets.top + maxRowIndex * (h + rowGap)
        attrs.frame = CGRect(x: x, y: y, width: w, height: h)
        
        /**
         * 注：1.cell的宽度和高度算起来比较简单 : 宽度由外部传进来，高度固定为rowHeight(默认为100)。
         *    2.cell的x : 通过tempItemX算好了。
         *    3.cell的y : minHeight最短列的高度，也就是最低高度，作为当前cell的起始y，当然要加上行之间的间隙。
         */
        itemAttributes.append(attrs)
        tempItemX += width
    }
    /**
     *  垂直瀑布：设置每一个attrs的frame，并加入数组中
     */
    func setVerticalFrame(indexPath: IndexPath) {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let w = itemWidth
        let h = itemHeights[indexPath.item]
        let x = insets.left + CGFloat(minIndex) * (w + columnGap)
        let y = minHeight + rowGap
        attrs.frame = CGRectMake(x, y, w, h)
        
        
        /**
         * 注：1.cell的宽度和高度算起来比较简单 : 宽度固定(itemWidth已经算好)，高度由外部传进来
         *    2.cell的x : minIndex最短列作为当前列。
         *    3.cell的y : minHeight最短列的高度，也就是最低高度，作为当前cell的起始y，当然要加上行之间的间隙。
         */
        
        columnsHeights[minIndex] = attrs.frame.maxY
        itemAttributes.append(attrs)
    }
    /**
     *  返回collectionView的尺寸
     */
    override var collectionViewContentSize: CGSize {
        var height = 0.0
        if type == 0 {
            height = maxHeight
        } else if type == 1 {
            let rowH = rowHeight == 0 ? 100 : rowHeight
            height = insets.top + (maxRowIndex + 1) * (rowH + rowGap)
        }
        return CGSize(width: collectionView?.frame.size.width ?? 0.0, height: height)
    }
    /**
     *  所有元素（比如cell、补充控件、装饰控件）的布局属性
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return itemAttributes
    }
}

class RAMCollectonViewBaseCell: UICollectionViewCell {
    
    var cellModel = RAMCellModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 25
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: RAMCellModel) {
        cellModel = model
    }
    
    func topViewController(_ top: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = top as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = top as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let pvc = top as? UIPageViewController {
            if let tpvc = pvc.viewControllers?.first {
                return topViewController(tpvc)
            }
        }
        if let presented = top?.presentedViewController {
            return topViewController(presented)
        }
        return top
    }
    
}

/// 仅一个标题按钮
class RAMButtonCell: RAMCollectonViewBaseCell {
    
    let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.frame = contentView.bounds
        button.setTitle("测试", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func setModel(_ model: RAMCellModel) {
        super.setModel(model)
        button.setTitle(model.title, for: .normal)
        button.isSelected = model.selected
    }
    
    
}


/// 标题 + switch按钮
class RAMSwitchCell: RAMCollectonViewBaseCell {
    
    let titleLabel = UILabel()
    
    let swi = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "标题"
        titleLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(titleLabel)
        
        swi.addTarget(self, action: #selector(swiClick(sender:)), for: .touchUpInside)
        contentView.addSubview(swi)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func swiClick(sender: UISwitch) {
        sender.isSelected = !sender.isSelected
    }
    
    override func setModel(_ model: RAMCellModel) {
        super.setModel(model)
        titleLabel.text = model.title
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(10, 25 - titleLabel.frame.height / 2, titleLabel.frame.width, titleLabel.frame.height)
        
        swi.setOn(model.selected, animated: false)
        swi.sizeToFit()
        swi.frame = CGRectMake(titleLabel.frame.maxX + 5, 25 - swi.frame.height / 2, swi.frame.width, swi.frame.height)
    }
}

// 标题加下拉选项的
class RAMListCell: RAMCollectonViewBaseCell {
    
    let titleLabel = UILabel()
    
    let button = UIButton()
    
    let arrowImage = UIImageView(image: UIImage(named: "down-arrow"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "标题"
        titleLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(titleLabel)
        
        button.frame = contentView.bounds
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        contentView.addSubview(button)
        
        contentView.addSubview(arrowImage)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func buttonClick(sender: UIButton) {
        
        if cellModel.list.count > 0 {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for e in cellModel.list {
                let action1 = UIAlertAction(title: e, style: .default) { [weak self] (_) in
                    self?.titleLabel.text = (self?.cellModel.title ?? "") + ": " + e
                    self?.resizeFrame()
                }
                alertController.addAction(action1)
            }
            let action4 = UIAlertAction(title: "取消", style: .cancel) { (_) in
            }
            alertController.addAction(action4)
            topViewController()?.present(alertController, animated: true, completion: nil)
        }

    }
    
    
    override func setModel(_ model: RAMCellModel) {
        super.setModel(model)
        titleLabel.text = model.title
        resizeFrame()
        
    }
    
    func resizeFrame() {
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(10, 25 - titleLabel.frame.height / 2, titleLabel.frame.width, titleLabel.frame.height)
        
        arrowImage.frame = CGRect(x: contentView.frame.maxX - 10 - 10, y: 25 - 10 / 2, width: 10, height: 10)
        
    }
}

enum RAMCellType {
    case button
    case switchui
    case list
}


class RAMCellModel {
    var type: RAMCellType = .button
    var title: String = "标题"
    var selected: Bool = false
    var list: [String] = []
    
    static func create(by type: RAMCellType = .button, title: String = "标题", selected: Bool = false, list: [String] = []) -> RAMCellModel {
        let model = RAMCellModel()
        model.type = type
        model.title = title
        model.selected = selected
        model.list = list
        return model
    }
    
    var width: CGFloat {
        let rect: CGRect = title.boundingRect(with: CGSizeMake(300, 50), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        let width = rect.width
        
        switch type {
        case .button:
            return max(50, 10 + width + 10)
        case .switchui:
            return 10 + width + 5 + 51 + 10
        case .list:
            var maxListStr = list.first
            for i in 0..<list.count {
                maxListStr = maxListStr?.count ?? 0 > list[i].count ? maxListStr : list[i]
            }
            let listrect: CGRect = (": " + (maxListStr ?? "")).boundingRect(with: CGSizeMake(300, 50), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
            let listwidth = listrect.width
            return 10 + width + 5 + listwidth + 10 + 10 + 10
        }
    }
    
    var cellType: String {
       switch type {
       case .button:
           return "RAMButtonCell"
       case .switchui:
           return "RAMSwitchCell"
       case .list:
           return "RAMListCell"
       }
    }
}


class RAMSwitchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var waterflowLayout = RAMWaterflowLayout()
    
    let cell_identifier:String = "collectionCell"
    let cell_head:String = "collectionHeadCell"
    
    let models = [RAMCellModel.create(by: .button, title: "按钮1"),
                  RAMCellModel.create(by: .button, title: "按钮22"),
                  RAMCellModel.create(by: .button, title: "按钮232"),
                  RAMCellModel.create(by: .switchui, title: "按钮232"),
                  RAMCellModel.create(by: .switchui, title: "按钮232"),
                  RAMCellModel.create(by: .switchui, title: "按钮232"),
                  RAMCellModel.create(by: .list, title: "按钮list", list: ["list0","list1","list2","list3list3list3"])]
    
    var widths: [CGFloat] {
        return models.map { $0.width }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
 
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
    }
    
    //分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    //每个cell中的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.cellType, for: indexPath)
        
        guard let cell_ = cell as? RAMCollectonViewBaseCell else { return cell }
        cell_.setModel(model)
        return cell_
    }
    
    
    //MARK: - 懒加载
    lazy var collectionView: UICollectionView = {
        
        waterflowLayout.type = 1
        waterflowLayout.itemWidths = widths
        
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 64), collectionViewLayout: waterflowLayout)
        collectionView.backgroundColor =  .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RAMListCell.self, forCellWithReuseIdentifier: "RAMListCell")
        collectionView.register(RAMSwitchCell.self, forCellWithReuseIdentifier: "RAMSwitchCell")
        collectionView.register(RAMButtonCell.self, forCellWithReuseIdentifier: "RAMButtonCell")
        
        return collectionView
    }()
 
}
