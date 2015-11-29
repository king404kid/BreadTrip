//
//  FilterController.swift
//  Breadtrip
//
//  Created by Feng on 15/10/28.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

protocol FilterBarDelegate: class {
    func changeItem(index1: Int, index2: Int, index3: Int)
}

class FilterBarController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var bg: FilterBgView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        bg = FilterBgView()
        item1 = FilterBarItem(frame: CGRectZero)
        item1.setTitle(SaleModel.instance.filterList[0].name)
        item2 = FilterBarItem(frame: CGRectZero)
        item2.setTitle(SaleModel.instance.filterList[1].name)
        item3 = FilterBarItem(frame: CGRectZero)
        item3.setTitle(SaleModel.instance.filterList[2].name)
        item4 = FilterBarItem(frame: CGRectZero)
        item4.setTitle(SaleModel.instance.filterList[3].name)
        grayViewBg = UIView()
        container = UIView()
        leftTable = UITableView()
        rightTable = UITableView()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
//        initButtons()
//        initContainer()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
        initContainer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func loadView() {
        // 设不设置frame都可以
//        let view = UIView(frame: UIScreen.mainScreen().applicationFrame)
        bg = FilterBgView()
        bg.backgroundColor = UIColor.clearColor()
        self.view = bg
    }
    
    //-------------------------   按钮部分   --------------------------
    
    var item1: FilterBarItem
    var item2: FilterBarItem
    var item3: FilterBarItem
    var item4: FilterBarItem
    
    private var selectedIndex1: Int = 0    // 当前选中下标1
    private var selectedIndex2: Int = 0    // 当前选中下标2
    private var selectedIndex3: Int = 0    // 当前选中下标3
    private var currentRenderingTypeIndex: Int = 0  // 当前展示的下标
    
    weak var delegate: FilterBarDelegate?
    
    // 初始化按钮
    func initButtons() {
        let gesture1 = UITapGestureRecognizer(target: self, action: "chooseHandler1:")
        let gesture2 = UITapGestureRecognizer(target: self, action: "chooseHandler1:")
        let gesture3 = UITapGestureRecognizer(target: self, action: "chooseHandler1:")
        let gesture4 = UITapGestureRecognizer(target: self, action: "chooseHandler1:")
        
        item1.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(item1)
        item1.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        item1.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        item1.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Height, ofView: self.view)
        item1.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self.view, withMultiplier: 1/4)
        item1.addGestureRecognizer(gesture1)
        item1.setColor(UIColor(red: 43/255, green: 235/255, blue: 255/255, alpha: 1))
        
        item2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(item2)
        item2.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: item1)
        item2.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        item2.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Height, ofView: self.view)
        item2.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self.view, withMultiplier: 1/4)
        item2.addGestureRecognizer(gesture2)
        
        item3.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(item3)
        item3.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: item2)
        item3.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        item3.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Height, ofView: self.view)
        item3.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self.view, withMultiplier: 1/4)
        item3.addGestureRecognizer(gesture3)
        
        item4.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(item4)
        item4.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: item3)
        item4.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        item4.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Height, ofView: self.view)
        item4.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self.view, withMultiplier: 1/4)
        item4.addGestureRecognizer(gesture4)
        item4.needsLine = false
    }
    
    // 选择类别1
    func chooseHandler1(sender: UITapGestureRecognizer) {
        if let item = sender.view as? FilterBarItem {
            switch item {
                case item1:
                    selectedIndex1 = 0
                case item2:
                    selectedIndex1 = 1
                case item3:
                    selectedIndex1 = 2
                case item4:
                    selectedIndex1 = 3
                default:
                    selectedIndex1 = 0
                    break
            }
            foldContainer(false)
            
            // 更新数据
            selectedIndex2 = 0
            selectedIndex3 = 0
            leftTable.reloadData()
            // 也可以在tableView的willDisplayCell做，不过需要加判断
//            dispatch_async(dispatch_get_main_queue()) {
//                println("lefttable 数据加载完成")
//            }
            leftTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
            println("由于reloadData是异步执行的，所以会比其他信息早出现")
            rightTable.reloadData()
            leftTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
            
            // 设置选中颜色
            setColorOnSelectedIndex()
            
            // 因为autolayout的原因，这里需要把绝对定位的动画改为通过约束来实现。需要注意的是，约束的顺序和调用问题
//            container.frame.origin.y = -CGFloat(FilterModel.instance.ITEM_HEIGHT * (FilterModel.instance.ITEM_NUM - 1))
            self.bottomConstraint!.constant = 0
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.4, animations: { () -> Void in
//                self.container.frame.origin.y = CGFloat(FilterModel.instance.ITEM_HEIGHT)
                self.bottomConstraint!.constant = CGFloat(FilterModel.instance.ITEM_HEIGHT * FilterModel.instance.ITEM_NUM)
                self.view.layoutIfNeeded()
            }) { (finished) -> Void in
                
            }
        }
    }
    
    // 折叠或展示容器
    func foldContainer(flag: Bool) {
        if flag {  // 折叠
            container.hidden = true
            grayViewBg.hidden = true
            bg.isFolding = true
            setColorOnSelectedIndex()
        } else {   // 展示
            container.hidden = false
            grayViewBg.hidden = false
            bg.isFolding = false
        }
    }
    
    //-------------------------   视图部分   --------------------------
    
    var grayViewBg: UIView   // 灰色隔挡层
    var container: UIView    // 下拉视图容器
    var leftTable: UITableView   // 左侧table
    var rightTable: UITableView  // 右侧table
    {
        didSet {
            // 记住，didSet只会在非构造函数初始化的其他情况下才会调用，这里是不会调用的。这里被坑了一次
        }
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    // 根据关系获取约束
    func getConstraintByAttribute(attr: NSLayoutAttribute, andArr arr: Array<NSLayoutConstraint>) -> NSLayoutConstraint? {
        for constraint in arr {
            if constraint.firstAttribute == attr {
                return constraint
            }
        }
        return nil
    }
    
    func initContainer() {
        grayViewBg.backgroundColor = UIColor.grayColor()
        grayViewBg.alpha = 0.4
        grayViewBg.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.insertSubview(grayViewBg, atIndex: 0)
        grayViewBg.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.view)
        grayViewBg.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.view)
        grayViewBg.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.view, withOffset: 0)
        grayViewBg.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.view, withOffset: 1000)
        grayViewBg.hidden = bg.isFolding
        let tapGrayViewGesture = UITapGestureRecognizer(target: self, action: "tapGrapView:")
        grayViewBg.addGestureRecognizer(tapGrayViewGesture)
        
        container.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.insertSubview(container, aboveSubview: grayViewBg)
        container.autoSetDimension(ALDimension.Height, toSize: CGFloat(FilterModel.instance.ITEM_HEIGHT * FilterModel.instance.ITEM_NUM))
        var arr = container.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: ALEdge.Top) as Array<NSLayoutConstraint>
        bottomConstraint = getConstraintByAttribute(NSLayoutAttribute.Bottom, andArr: arr)
//        bottomConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        container.hidden = bg.isFolding
        
        leftTable.showsVerticalScrollIndicator = false
        leftTable.delegate = self
        leftTable.dataSource = self
        leftTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "leftCell")
        leftTable.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(leftTable)
        leftTable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: ALEdge.Right)
        leftTable.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: container, withMultiplier: 1/2)
        
        rightTable.showsVerticalScrollIndicator = false
        rightTable.layoutMargins = UIEdgeInsetsZero
        rightTable.separatorInset = UIEdgeInsetsZero
        rightTable.delegate = self
        rightTable.dataSource = self
        rightTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "rightCell")
        rightTable.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(rightTable)
        rightTable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: ALEdge.Left)
        rightTable.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: container, withMultiplier: 1/2)
    }
    
    func tapGrapView(sender: UITapGestureRecognizer) {
        foldContainer(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTable {
            let saleFilterVo = SaleModel.instance.filterList[selectedIndex1]
            return saleFilterVo.arr.count
        } else {
            let saleFilterVo = SaleModel.instance.filterList[selectedIndex1]
            let saleTypeVo = saleFilterVo.arr[selectedIndex2]
            return saleTypeVo.arr.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 解决cell里面分割线左移15像素问题，有以下两种方法，分别用于leftTable和rightTable：
        // 1. leftTable: 设置cell的preservesSuperviewLayoutMargins为false，layoutMargins为UIEdgeInsetsZero，separatorInset为UIEdgeInsetsZero
        // 2. rightTable: 设置table的layoutMargins为UIEdgeInsetsZero，separatorInset为UIEdgeInsetsZero，设置cell的layoutMargins为UIEdgeInsetsZero，separatorInset为UIEdgeInsetsZero
        if tableView == leftTable {
            let cell = tableView.dequeueReusableCellWithIdentifier("leftCell") as UITableViewCell
            let saleFilterVo = SaleModel.instance.filterList[selectedIndex1]
            cell.textLabel?.text = saleFilterVo.arr[indexPath.row].name
            cell.preservesSuperviewLayoutMargins = false
            cell.layoutMargins = UIEdgeInsetsZero
            cell.separatorInset = UIEdgeInsetsZero
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel?.highlightedTextColor = UIColor(red: 43/255, green: 235/255, blue: 255/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.blackColor()
            if selectedIndex2 == indexPath.row {
                cell.textLabel?.highlighted = true
            } else {
                cell.textLabel?.highlighted = false
            }
            println("lefttable cellForRowAtIndexPath: \(indexPath.row)")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("rightCell") as UITableViewCell
            let saleFilterVo = SaleModel.instance.filterList[selectedIndex1]
            let saleTypeVo = saleFilterVo.arr[selectedIndex2]
            cell.textLabel?.text = saleTypeVo.arr[indexPath.row].name
            cell.layoutMargins = UIEdgeInsetsZero
            cell.separatorInset = UIEdgeInsetsZero
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel?.highlightedTextColor = UIColor(red: 43/255, green: 235/255, blue: 255/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.blackColor()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(FilterModel.instance.ITEM_HEIGHT)
    }
    
    // 选中某项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedIndex = indexPath.row
        if tableView == leftTable {
            selectedIndex2 = selectedIndex
            rightTable.reloadData()
            rightTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
            setColorOnSelectedIndex()
        } else {
            selectedIndex3 = selectedIndex
            currentRenderingTypeIndex = selectedIndex1
            foldContainer(true)
            delegate?.changeItem(selectedIndex1, index2: selectedIndex2, index3: selectedIndex3)
        }
    }
    
    // 此方法在设置了cell的data后(cellForRowAtIndexPath)调用，可以用于判断加载到第几个cell。这里使用到一个场景，例如你要reloadData后知道什么时候完成，就可以通过判断最后一个来确定是否加载完成。需要注意的是，由于reloadData后，主线程那时候会变得很忙，这时我们发送一个异步信息，该信息会等到主线程忙完(完成reloadData后)再去触发，所以网上也有说直接在reloadData后面加一个异步信息就好
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == leftTable {
            println("lefttable willDisplayCell: \(indexPath.row)")
        }
        if tableView == leftTable {
            if let rowPath = tableView.indexPathsForVisibleRows()?.last as? NSIndexPath {
                if rowPath.row == indexPath.row {
                    dispatch_async(dispatch_get_main_queue()) {
                        println("lefttable 数据加载完成，row \(rowPath.row)")
                    }
                }
            }
        }
    }
    
    // 设置选中颜色
    func setColorOnSelectedIndex() {
        // 上面那排按钮
        let arr = [item1, item2, item3, item4]
        for item in arr {
            item.setColor(UIColor.blackColor())
        }
        let index = bg.isFolding ? currentRenderingTypeIndex : selectedIndex1
        let item = arr[index]
        item.setColor(UIColor(red: 43/255, green: 235/255, blue: 255/255, alpha: 1))
        
        // 左侧table
        let leftTableRowsNum = leftTable.numberOfRowsInSection(0)
        for var i = 0; i < leftTableRowsNum; i++ {
            let cell = leftTable.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0))
            if i == selectedIndex2 {
                cell?.textLabel?.highlighted = true
            } else {
                cell?.textLabel?.highlighted = false
            }
        }
    }
}
