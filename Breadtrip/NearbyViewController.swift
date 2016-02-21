//
//  NearbyViewController.swift
//  Breadtrip
//
//  Created by Feng on 15/8/16.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class NearbyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 类似uiview里面的setNeedsDisplay，让系统下次刷新的时候调用preferredStatusBarStyle()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // 隐藏tabbar，之所以放在这里跟上面原因一样
//        self.tabBarController?.tabBar.hidden = true
        
        // 取消选中状态
        if let selectedIndex = nearbyTableView.indexPathForSelectedRow() {
            nearbyTableView.deselectRowAtIndexPath(selectedIndex, animated: false)  // 注意调用后的选中index已经不存在了
        }
        
        // 实在找不到方法，强制画一个view作为导航栏的背景
//        var statusBg = UIView(frame: CGRect(x: 0, y: -20, width: 375, height: 20))
//        statusBg.backgroundColor = UIColor.blackColor()
//        self.navigationController?.navigationBar.addSubview(statusBg)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setDefaultSelectItem(0, section: 0)   // 设置默认选中第一个
    }
    
    // 改用白色字体
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }
    
    // 此方法可以用于以下情景：tabbar->nav->vc1->vc2->v3，想在vc1和vc3显示tabbar，vc2不显示，如果单纯的在vc1的prepareForSegue设置vc2的hidesBottomBarWhenPushed为true，是可以达到vc2隐藏，vc1显示的效果。问题是，vc3也同时会隐藏，即使在vc2的prepareForSegue设置vc2的hidesBottomBarWhenPushed为false也没用。官方的说法是：If YES, the bottom bar remains hidden until the view controller is popped from the stack.也就意味着，一天vc2还在栈里面，一天tabbar都还处于隐藏状态。对于此问题，解决方法有好几个，以下这个是其中之一。另外也可以在隐藏了vc2的tabbar之后马上把vc2的hidesBottomBarWhenPushed属性设回去false，这种方法就要时刻保证状态的正确性。还有一种做法是直接隐藏tabbarcontroller.tabbar，设置tabbar的hidden属性，也方便
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return self.navigationController?.topViewController == self
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    ///////////////////////////////////////////////////////
    
    @IBOutlet weak var nearbyCollectionView: UICollectionView! {
        didSet {
            nearbyCollectionView.showsHorizontalScrollIndicator = false
            let layout = nearbyCollectionView.collectionViewLayout as UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: 80, height: 49) // 为了显示一行，这里的高度要跟collectionview高度一样
            
//            let num = NearbyModel.instance.typeList.count
//            nearbyCollectionView.contentSize = CGSize(width: CGFloat(num) * layout.itemSize.width, height: layout.itemSize.height)    // 这里设置了contentsize没效，后面设置item(cellForItemAtIndexPath)的时候，断点发现contentSize又被改了，其实在collectoinview里面是不需要手动设置contentsize，内部会根据方向自动填充
            
            // 为了让滑块显示在底部，所以把背景设置成透明
            nearbyCollectionView.backgroundColor = UIColor.clearColor()
        }
    }
    
    // 设置默认选中的item
    func setDefaultSelectItem(row: Int, section: Int) {
        let indexPath = NSIndexPath(forItem: row, inSection: section)
        // 调用系统选中函数，滚动到指定位置
        nearbyCollectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.None)
        // 调用自定义选中函数
        self.selectedCell?.animateSelected = false
        if let cell = nearbyCollectionView.cellForItemAtIndexPath(indexPath) as? NearbyCollectionCell {
            self.selectedCell = cell
            self.selectedCell?.animateSelected = true
            // 把cell里面的按钮坐标转换成全局坐标，注意参数的顺序(toView与fromView)
            originFrame = cell.convertRect(cell.nearbyItem.frame, toView: self.view)
            var layout = nearbyCollectionView.collectionViewLayout as UICollectionViewFlowLayout
            // 这里要算出第一个的准确位置，由于默认有可能不是第一个，所以要减去多余偏移
            originFrame?.origin.x -= layout.itemSize.width * CGFloat(row)
            lastName = cell.nearbyItem.currentTitle
            lastIndex = CGFloat(indexPath.row)
        }
    }
    
    // 滑块，用于选中滑动动画
    private var originFrame: CGRect?   // 默认第一个cell里面的item参数，用于计算动画
    private var lastIndex: CGFloat = 0
    private var lastName: String?
    private var selectedCell: NearbyCollectionCell?
    private var selectedIndex: CGFloat = 0
    private var slider: UIView?
    
    // 画滑块
    func drawSlider() {
        if originFrame != nil {
            var frame = originFrame!
            var layout = nearbyCollectionView.collectionViewLayout as UICollectionViewFlowLayout
            // 计算上次选中cell的位置，由于复用的原因，不能简单的通过记录cell变量来获取，而要通过偏移计算
            frame.origin.x += layout.itemSize.width * lastIndex - nearbyCollectionView.contentOffset.x
            slider = slider ?? UIView()
            slider?.frame = frame
            slider?.backgroundColor = UIColor(red: 11/255, green: 141/255, blue: 138/255, alpha: 1)
            slider?.layer.cornerRadius = slider!.bounds.height / 2
            slider?.layer.masksToBounds = true
            self.view.insertSubview(slider!, atIndex: 0)
        }
    }
    
    // 滑块移动动画
    func animateSlider() {
        if selectedCell != nil {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                var frame = self.selectedCell!.convertRect(self.selectedCell!.nearbyItem.frame, toView: self.view)
                self.slider?.frame = CGRect(origin: frame.origin, size: frame.size)
            }) { (finished) -> Void in
                self.selectedCell?.animateSelected = true
                self.lastName = self.selectedCell?.nearbyItem.currentTitle
                self.lastIndex = self.selectedIndex
                self.slider?.removeFromSuperview()
                self.refresh()  // 手动更新
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NearbyModel.instance.typeList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("nearbyCollectionCell", forIndexPath: indexPath) as NearbyCollectionCell
        let list = NearbyModel.instance.typeList
        cell.nearbyItem.setTitle(list[indexPath.row], forState: UIControlState.Normal)
        // 因为复用的原因，所以每次更新值的时候要检测选中状态
        if cell.nearbyItem.currentTitle != lastName {
            cell.animateSelected = false
        } else {
            cell.animateSelected = true
        }
        return cell
    }
    
    // ios的点击是不会冒泡触发的，一旦找到一个可以响应的对象，就会停止，所以要把cell里面的button的点击交互禁用
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? NearbyCollectionCell
        let cell = nearbyCollectionView.cellForItemAtIndexPath(NSIndexPath(forItem: Int(lastIndex), inSection: 0)) as? NearbyCollectionCell
        cell?.animateSelected = false
        selectedIndex = CGFloat(indexPath.row)
        drawSlider()
        animateSlider()
    }
    
    ///////////////////////////////////////////////////////
    
    private var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var nearbyTableView: UITableView! {
        didSet {
            refreshControl = UIRefreshControl()
            refreshControl?.attributedTitle = NSAttributedString(string: "正在努力加载中...")
            refreshControl?.addTarget(self, action: "refreshView:", forControlEvents: UIControlEvents.ValueChanged)
            nearbyTableView.addSubview(refreshControl!)
        }
    }
    
    // 更新列表数据
    func refreshView(control: UIRefreshControl) {
        refreshControl?.endRefreshing()
        nearbyTableView.reloadData()
    }
    
    // 调用更新
    func refresh() {
        if let control = refreshControl {
            control.beginRefreshing()
            var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerHandler:", userInfo: nil, repeats: false)
        }
    }
    
    // 模拟触发刷新
    func timerHandler(timer: NSTimer) {
        println("timer trigger")
        if let control = refreshControl {
            refreshView(control)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NearbyModel.instance.nearbyList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nearbyTableCell") as NearbyTableCell
        let list = NearbyModel.instance.nearbyList[Int(selectedIndex)]
        assert(indexPath.row < list.count, "索引超出范围")
        let vo = list[indexPath.row]
        cell.setData(vo)
        return cell
    }
}
