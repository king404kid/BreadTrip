//
//  BannerViewController.swift
//  Breadtrip
//
//  Created by Feng on 15/6/22.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

protocol BannerViewTapDelegate: class {
    func bannerImageTap(index: Int)
}

class BannerViewController: UIViewController, UIScrollViewDelegate
{
    weak var delegate: BannerViewTapDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBanner()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        initBannerWithFrame()
        setIndex(0)   // 显示第几页
        addTimer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeTimer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private var pageFrame: CGRect?
    
    // 此时frame已经设置好了，可以使用
    private func initBannerWithFrame() {
        if pageFrame == nil {
            pageFrame = bannerScrollView.frame
            
            // 因为涉及frame的计算，所以不能放在viewDidLoad里面，只能放在viewDidAppear
            
            // 设置滚动区域大小
            let pagesScrollViewSize = pageFrame!.size
            bannerScrollView.contentSize = CGSize(width: pagesScrollViewSize.width * 3, height: 0)    // 防止上下滚动
            
            // 初始化3个UIImageView用于循环播放
            var origin = CGPoint(x: pagesScrollViewSize.width, y: 0)
            currentImageView = UIImageView(frame: CGRect(origin: origin, size: pagesScrollViewSize))
            currentImageView?.image = pageImages[0]
            bannerScrollView.addSubview(currentImageView!)
            currentImageView?.userInteractionEnabled = true
            let imageTapGesture = UITapGestureRecognizer(target: self, action: "imageTap:")
            currentImageView?.addGestureRecognizer(imageTapGesture)
            
            origin.x = pagesScrollViewSize.width * 2
            nextImageView = UIImageView(frame: CGRect(origin: origin, size: pagesScrollViewSize))
            nextImageView?.image = pageImages[1]
            bannerScrollView.addSubview(nextImageView!)
            
            origin.x = 0
            previousImageView = UIImageView(frame: CGRect(origin: origin, size: pagesScrollViewSize))
            previousImageView?.image = pageImages[bannerPage.numberOfPages-1]
            bannerScrollView.addSubview(previousImageView!)
        }
    }
    
    // 定位
    private func setIndex(var index: Int) {
        if index < 0 || index >= bannerPage.numberOfPages {
            index = 0
        }
        if let pagesScrollViewSize = pageFrame?.size {
            var origin = CGPoint(x: pagesScrollViewSize.width, y: 0)
            bannerScrollView.contentOffset = origin
            bannerIndex = index
            bannerPage.currentPage = bannerIndex
            currentImageView?.image = pageImages[bannerIndex]
            previousImageView?.image = bannerIndex == 0 ? pageImages[bannerPage.numberOfPages-1] : pageImages[bannerIndex-1]
            nextImageView?.image = bannerIndex == bannerPage.numberOfPages-1 ? pageImages[0] : pageImages[bannerIndex+1]
        }
    }
    
    // 这里不能加private前缀，要不然找不到次方法，又被坑了好久
    func imageTap(sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        delegate?.bannerImageTap(bannerIndex)
    }
    
    // 横幅图片
    @IBOutlet weak var bannerScrollView: UIScrollView! {
        didSet {
            bannerScrollView.delegate = self
            bannerScrollView.showsHorizontalScrollIndicator = false
            bannerScrollView.bounces = false   // 是否需要回弹
            bannerScrollView.pagingEnabled = true // 翻页关键一句，苹果内部会自动停止滚动
        }
    }
    
    // 横幅页签
    @IBOutlet weak var bannerPage: UIPageControl!
    
    // 只需要3张图片循环播放，达到无限图片的效果
    var currentImageView: UIImageView?   // 当前显示图片
    var nextImageView: UIImageView?      // 下一张显示图片
    var previousImageView: UIImageView?  // 前一张显示图片
    
    var pageImages = [UIImage?]()    //  每页要显示的图片
    var bannerIndex = 0    // 当前显示第几张图片
    
    // 初始化横幅信息
    private func initBanner() {
        pageImages = [UIImage(named: "banner1.jpg"),
            UIImage(named: "banner2.jpg"),
            UIImage(named: "banner3.jpg"),
            UIImage(named: "banner4.jpg"),
            UIImage(named: "banner5.jpg")]
        
        let pageCount = pageImages.count
        
        bannerPage.currentPage = 0
        bannerPage.numberOfPages = pageCount
    }
    
    // 加载可视部分图片
    private func loadVisiblePages() {
        if pageFrame == nil {
            return
        }
        
//        // 计算当前第几页
//        let pageWidth = pageFrame!.size.width
//        let page = Int(floor((pageWidth * 1/2 + bannerScrollView.contentOffset.x) / pageWidth))    // 拖动1/2距离即可
        
        let offset = bannerScrollView.contentOffset
        
        if previousImageView?.image == nil || nextImageView?.image == nil {
            previousImageView?.image = bannerIndex == 0 ? pageImages[bannerPage.numberOfPages-1] : pageImages[bannerIndex-1]
            nextImageView?.image = bannerIndex == bannerPage.numberOfPages-1 ? pageImages[0] : pageImages[bannerIndex+1]
        }
        let pagesScrollViewSize = pageFrame!.size
        if offset.x <= 0 {
            currentImageView?.image = previousImageView?.image
            bannerScrollView.contentOffset = CGPoint(x: pagesScrollViewSize.width, y: 0)
            previousImageView?.image = nil
            if bannerIndex == 0 {
                bannerIndex = bannerPage.numberOfPages - 1
            } else {
                bannerIndex--
            }
            bannerPage.currentPage = bannerIndex
        }
        if offset.x >= 2 * pagesScrollViewSize.width {
            currentImageView?.image = nextImageView?.image
            bannerScrollView.contentOffset = CGPoint(x: pagesScrollViewSize.width, y: 0)
            nextImageView?.image = nil
            if bannerIndex == bannerPage.numberOfPages - 1 {
                bannerIndex = 0
            } else {
                bannerIndex++
            }
            bannerPage.currentPage = bannerIndex
        }
    }
    
    // 滚动的时候触发，会触发多次
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == bannerScrollView {
            loadVisiblePages()
        }
    }
    
    // 下一张横幅
    private func nextBanner() {
        var offsetPoint = bannerScrollView.contentOffset
        let pagesScrollViewSize = pageFrame!.size
        offsetPoint.x += pagesScrollViewSize.width
        bannerScrollView.setContentOffset(offsetPoint, animated: true)
    }
    
    // 自动滚动
    private var timer: NSTimer?
    
    func addTimer() {
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "timerHandler:", userInfo: nil, repeats: true)
            timer?.tolerance = 0.4
        }
    }
    
    func removeTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func timerHandler(myTimer: NSTimer) {
        nextBanner()
    }
}
