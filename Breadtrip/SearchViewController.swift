//
//  SearchViewController.swift
//  Breadtrip
//
//  Created by Feng on 15/7/19.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SearchBarDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
    }
    
    // 这里会触发两次，第一次是做动画的时候insertSubview，第二次是动画完成后presentViewController
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("search viewDidAppear")
        
//        searchBarController!.setFristResponder()

        // 可以在这里通过layout统一改变大小，也可以通过delegate的方式单独处理
//        let layout = collectionView.collectionViewLayout as UICollectionViewFlowLayout
//        let collectionSize = collectionView.frame.size
//        let size = CGSize(width: collectionSize.width / 4, height: 50)
//        layout.itemSize = size
    }
    
    // 切换时供外部调用
    func setFirstResponder() {
        searchBarController!.setFristResponder()
    }
    
    ///////////////////////////////////////////////
    
    @IBOutlet weak var searchBarContainer: UIView!
    
    var searchBarController: SearchBarController? {
        didSet {
            searchBarController?.delegate = self
        }
    }
    
    private func addSearchBar() {
        searchBarController = searchBarController ?? SearchBarController(nibName: "SearchBarController", bundle: nil)
        self.addChildViewController(searchBarController!)
        searchBarContainer.addSubview(searchBarController!.view)
        var frame = searchBarContainer.frame
        frame.origin = CGPointZero
        searchBarController!.view.frame = frame
    }
    
    func clickBtn() {
        self.performSegueWithIdentifier("unwindSearchSegueId", sender: self)
    }
    
    ///////////////////////////////////////////////
    
    @IBOutlet weak var collectionView: UICollectionView! { // 先绑定，再viewDidLoad
        didSet {
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(SearchModel.instance.OFFSET), bottom: 0, right: CGFloat(SearchModel.instance.OFFSET))
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let list = SearchModel.instance.headerList
        return list.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchModel.instance.favoriteForeignPlaceList.count
    }
    
    // 复用的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchCell", forIndexPath: indexPath) as! SearchViewCell
        var list = SearchModel.instance.favoriteForeignPlaceList
        if indexPath.section == 2 {
            list = SearchModel.instance.favoriteDomesticPlaceList
        }
        cell.contentBtn.setTitle(list[indexPath.row], forState: UIControlState.Normal)
//        cell.backgroundColor = UIColor.greenColor()
        return cell
    }
    
    // 复用的header或footer
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var supplementaryView: UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "searchHeader", forIndexPath: indexPath) as! SearchHeaderView
            let list = SearchModel.instance.headerList
            headerView.name.text = list[indexPath.section]
            supplementaryView = headerView
        }
        return supplementaryView!
    }
    
    // 设置每个cell的大小，可以在这里通过layout统一改变大小，也可以通过delegate的方式单独处理
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionSize = collectionView.frame.size
        let size = CGSize(width: (collectionSize.width - CGFloat(SearchModel.instance.OFFSET) * 2) / 3, height: 50)
        return size
    }
    
    // 最小间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    // 最小行距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    // section外边距，这里用了collectionView的flowlayout去统一设置
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: CGFloat(SearchModel.instance.OFFSET), bottom: 0, right: CGFloat(SearchModel.instance.OFFSET))
//    }
    
    ///////////////////////////////////////////////
}
