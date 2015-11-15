//
//  SaleController.swift
//  Breadtrip
//
//  Created by Feng on 15/5/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SaleController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterBarDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 不需要系统偏移滚动
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 不要延伸到底部
        self.edgesForExtendedLayout = UIRectEdge.Top | UIRectEdge.Left | UIRectEdge.Right
        
        initTitle()
        initFilterBar()
        initTable()
        initBanner()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        changeSubView()  // 此函数不能放在viewDidLoad里面，因为视图布局还没完成就改变顺序，会导致autoLayout出问题
    }
    
    // 改变顺序
    func changeSubView() {
        self.view.addSubview(filterBarController!.view)
    }
    
    //-------------------------   标题部分   --------------------------
    
    // 创建标题
    func initTitle() {
        // 背景和字体颜色已经在AppDelegate那边统一处理，所以这里不需要设置
        self.navigationItem.title = "特价"
    }
    
    //-------------------------   筛选栏部分   --------------------------
    
    var filterBarController: FilterBarController? {
        didSet {
            filterBarController?.delegate = self
        }
    }
    
    // 创建筛选栏
    func initFilterBar() {
        filterBarController = filterBarController ?? FilterBarController(nibName: nil, bundle: nil)
        self.addChildViewController(filterBarController!)
        self.view.addSubview(filterBarController!.view)
        filterBarController!.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        filterBarController!.view.autoSetDimension(ALDimension.Height, toSize: CGFloat(FilterModel.instance.ITEM_HEIGHT))
        filterBarController!.view.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 20+44, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Bottom)
    }
    
    // 当fitlerbar选中项改变时
    func changeItem(index1: Int, index2: Int, index3: Int) {
        selected1 = index1
        selected2 = index2
        selected3 = index3
        tableView?.reloadData()
        // 这里因为有tableHeaderView的缘故，所以不能呢用scrollToRowAtIndexPath方法，因为该方法只能滚动到对应的行，而不是顶部
        tableView?.setContentOffset(CGPointZero, animated: true)
    }
    
    //-------------------------   banner部分   --------------------------
    
    var bannerController: BannerViewController?
    
    // 创建banner
    func initBanner() {
        // 这里需要注意的是，想把外部做好的控件(包含对应的controller)放入tableHeaderView，需要先创建一个view作为容器(也就是tableHeaderView)，然后把做好的控件放进去。而通过直接把控件里面的.view作为tableHeaderView(注释部分)会出现以下问题：在其viewDidAppear里面无法正常获取view的高度
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 145))   // 宽度填多少都无所谓
        tableView?.tableHeaderView = view
        bannerController = bannerController ?? BannerViewController(nibName: "BannerViewController", bundle: nil)
        self.addChildViewController(bannerController!)
        view.addSubview(bannerController!.view)
//        bannerController!.view.frame = CGRect(x: 0, y: 0, width: 20, height: 145)
//        tableView?.tableHeaderView = bannerController!.view
        bannerController!.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        bannerController!.view.autoPinEdgesToSuperviewEdges()
    }
    
    //-------------------------   table部分   --------------------------
    
    var selected1:Int = 0    // 当前选中分类1
    
    var selected2:Int = 0    // 当前选中分类2
    
    var selected3:Int = 0    // 当前选中分类3
    
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.registerClass(SaleTableCell.self, forCellReuseIdentifier: "SaleCell")
            tableView?.showsVerticalScrollIndicator = false
            tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        }
    }
    
    // 创建table内容
    func initTable() {
        tableView = tableView ?? UITableView()
        tableView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(tableView!)
        tableView!.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Top)
        tableView!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: filterBarController!.view)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getContentList().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let list = getContentList()
        let vo = list[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SaleCell") as SaleTableCell
        cell.picView.image = UIImage(named: vo.pic)
        cell.titleLabel.text = vo.title
        cell.dateLable.text = "出发日期：\(vo.dateArray)"
        cell.placeLabel.text = "\(vo.place)出发"
        cell.salePriceLabel.text = "\(vo.salePrice)元起"
        cell.originPriceLabel.text = "市场价：\(vo.salePrice)"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func getContentList() -> Array<SaleVo> {
        let vo1 = SaleModel.instance.filterList[selected1]
        let vo2 = vo1.arr[selected2]
        let vo3 = vo2.arr[selected3]
        return vo3.arr
    }
}
