//
//  ViewController.swift
//  Breadtrip
//
//  Created by Feng on 15/5/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class RecommendController: UIViewController, UITableViewDataSource, UITableViewDelegate, BannerViewTapDelegate, SearchBarDelegate
{
    ///////////////////////////////////////////////////////
    
    @IBOutlet weak var searchBarContainer: UIView!
    
    var searchController: SearchViewController?
    
    var searchBarController:SearchBarController? {
        didSet {
            searchBarController?.delegate = self
        }
    }
    
    private func addSearchBar() {
        searchBarController = SearchBarController(nibName: "SearchBarController", bundle:nil)
        self.addChildViewController(searchBarController!)
        searchBarContainer.addSubview(searchBarController!.view)
//        var frame = searchBarContainer.frame
//        frame.origin = CGPointZero
//        searchBarController!.view.frame = frame
        
        var contentView = searchBarController!.view
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let left = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: searchBarContainer, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        left.active = true
        let right = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: searchBarContainer, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        right.active = true
        let top = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: searchBarContainer, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        top.active = true
        let bottom = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: searchBarContainer, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        bottom.active = true
    }
    
    // 开始编辑
    func editBegin() {
//        searchController = searchController ?? self.storyboard?.instantiateViewControllerWithIdentifier("searchView") as? SearchViewController
//        self.presentViewController(searchController!, animated: true) {
//            
//        }
        
        self.performSegueWithIdentifier("searchSegueId", sender: self)
    }
    
    // 点击取消
    func clickBtn() {
        
    }
    
    // 点击附近
    func nearbyBtn() {
        self.performSegueWithIdentifier("showNearby", sender: self)
    }
    
    // 切换时供外部调用
    func setResignFristResponder() {
        searchBarController!.resignFristResponder()
    }
    
    ///////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 以下两种方法都可以消除scrollView的默认系统偏移
        
        // 看这个UIViewController的这个属性你就明白了，此属性默认为YES，这样UIViewController下如果只有一个UIScollView或者其子类，那么会自动留出空白，让scollview滚动经过各种bar下面时能隐约看到内容。但是每个UIViewController只能有唯一一个UIScollView或者其子类，如果超过一个，需要将此属性设置为NO,自己去控制留白以及坐标问题。我的观察是，如果不加这句话，bannerScrollView的contentOffset.y每次都被设置了-64
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 在IOS7以后 ViewController 开始使用全屏布局的，而且是默认的行为通常涉及到布局就离不开这个属性 edgesForExtendedLayout，它是一个类型为UIExtendedEdge的属性，指定边缘要延伸的方向，它的默认值很自然地是UIRectEdgeAll，四周边缘均延伸，就是说，如果即使视图中上有navigationBar，下有tabBar，那么视图仍会延伸覆盖到四周的区域。
//        self.edgesForExtendedLayout = UIRectEdge.None
        
        addBanner()
        
        addSearchBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏，之所以放在这里是因为viewDidLoad只会触发一次，切换回来还是要重新隐藏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // 隐藏tabbar，之所以放在这里跟上面原因一样
//        self.tabBarController?.tabBar.hidden = false
        
        // 取消选中状态
        if let selectedIndex = recommendTable.indexPathForSelectedRow() {
            recommendTable.deselectRowAtIndexPath(selectedIndex, animated: false)  // 注意调用后的选中index已经不存在了
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
    
    override func viewControllerForUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject?) -> UIViewController? {
        return super.viewControllerForUnwindSegueAction(action, fromViewController: fromViewController, withSender: sender)
    }
    
    // 这里的方法不会调用，调用的是RecommendNavController
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        if let id = identifier {
            if id == "unwindSearchSegueId" {
                let unwindSegue = SearchUnwindSegue(identifier: identifier, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            }
        }
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
    }
    
    // 可以通过次方法来隐藏tabbar，或者直接在sb里面勾选nearbyviewcontroller里面的hidesBottomBarWhenPushed，但是有一点不明白的是，通过这个属性来隐藏tabbar，会有明显的切换动画，不知道如何去掉，可以考虑直接隐藏tabbar来处理
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let id = segue.identifier {
//            switch id {
//                case "showNearby":
//                    if let dvc = segue.destinationViewController as? NearbyViewController {
//                        dvc.hidesBottomBarWhenPushed = true
//                    }
//                default:
//                    break
//            }
//        }
//    }
    
    ///////////////////////////////////////////////////////
    
    // 加banner期间遇到一个比较容易犯错的问题：我设置了bannerContainer的height为145，而加进来的banner高度400，就会导致多出来的部分没有触发到交互的滚动事件，事实上顶部的145区域还是能接受该事件的，并不是因为多了一个容器导致失效，而是容器的区域内才能触发，以外就不能
    @IBOutlet weak var bannerContainer: UIView!
    
    // 想在uiviewcontroller使用复用的xib(带viewcontroller)，发现有可能不触发复用的viewDidAppear，经过摸索有以下两种方法解决：
    // 1.在添加addSubview到父类之前，加入自带的controller，这里系统貌似会帮忙调用子类的viewDidAppear
    // 2.在父类的uiviewcontroller里面调用子类的viewDidAppear显示使用
    var bannerViewController: BannerViewController? {
        didSet {
            bannerViewController?.delegate = self
        }
    }
    
    var bannerDetailController: UIViewController?
    
    // 这里有两种方式使得子类自适应于父类。第一种，利用autoresizingMask，设置其frame达到，如下面演示的例子，注意要先addSubview再设置frame，确保父类的autoresizesSubviews为true，子类的autoresizingMask设置正确，子类的translatesAutoresizingMaskIntoConstraints()为true，即可
    // 第二种方法，用新的autolayout方式，不要设置frame，然后给子类加上constraint，添加到父类，禁用autoresizingMask(即子类的translatesAutoresizingMaskIntoConstraints()为false)。见addSearchBar()
    private func addBanner() {
        bannerViewController = BannerViewController(nibName: "BannerViewController", bundle: nil)
        self.addChildViewController(bannerViewController!)
        bannerContainer.addSubview(bannerViewController!.view)
        
        // 不知道为毛，以下几个函数分别调用以下frame设置，只有viewDidAppear会导致banner内部的图片没有正常缩放，经过断点发现在banner里面initBannerWithFrame的函数，获得的高度不正确，但是具体原因还不清楚，不知道是不是viewDidAppear内部发送有什么问题(有可能是viewDidAppear是最后触发的原因，那时候自动缩放已经早已触发了，但是不确定)。另外一点比较奇怪的是：我习惯了viewDidLoad里面不设置坐标，因为此时view的bounds其实没有真正初始化好，但是这里设置banner的frame却能够得到想要的效果，为毛！
        var frame = bannerContainer.frame
        frame.origin = CGPointZero
        bannerViewController!.view.frame = frame
    }
    
    // 点击图片
    func bannerImageTap(index: Int) {
        bannerDetailController = bannerDetailController ?? self.storyboard?.instantiateViewControllerWithIdentifier("bannerDetail") as? UIViewController
        self.navigationController?.pushViewController(bannerDetailController!, animated: true)
    }
    
    ///////////////////////////////////////////////////////
    
    @IBOutlet weak var recommendTable: UITableView! {
        didSet {
            recommendTable.dataSource = self
            recommendTable.delegate = self
            recommendTable.showsVerticalScrollIndicator = false
            recommendTable.separatorStyle = UITableViewCellSeparatorStyle.None  // 不显示table的分割条
        }
    }
    
    // 返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recommendVoList = RecommendModel.instance.recommendVoList
        return recommendVoList.count
    }
    
    // 设置某行
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recommendCell", forIndexPath: indexPath) as RecommendTableViewCell
//        cell.selectionStyle = UITableViewCellSelectionStyle.None  // 不需要选中状态
        let recommendVoList = RecommendModel.instance.recommendVoList
        let recommendVo = recommendVoList[indexPath.row]
        cell.pic.image = UIImage(named: recommendVo.picName)
        return cell
    }
    
    // 改写行高为固定值
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
}

