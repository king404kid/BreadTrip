//
//  DestinationController.swift
//  Breadtrip
//
//  Created by Feng on 15/5/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class DestinationController: UIViewController, SearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DestinationDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testPureLayout()
        
        // 不要延伸到底部
        self.edgesForExtendedLayout = [UIRectEdge.Top, UIRectEdge.Left, UIRectEdge.Right]
        
        initSearchBar()
        initCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //-------------------------   搜索栏部分   --------------------------
    
    var searchBar: UIView?
    
    var searchBarController: SearchBarController? {
        didSet {
            searchBar = searchBarController!.view
            searchBarController!.delegate = self
        }
    }
    
    // 手工设置搜索栏
    func initSearchBar() {
        searchBarController = searchBarController ?? SearchBarController(nibName: "SearchBarController", bundle: nil)
        self.addChildViewController(searchBarController!)
        self.view.addSubview(searchBar!)
        searchBar!.translatesAutoresizingMaskIntoConstraints = false
        searchBar!.autoSetDimension(ALDimension.Height, toSize: 50)
        searchBar!.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Bottom)
    }
    
    // 点击取消
    func clickBtn() {
        
    }
    
    //-------------------------   collectionView部分   --------------------------
    
    var detailViewController: DestinationDetailController?
    
    var collectionView: UICollectionView? {
        didSet {
            collectionView?.backgroundColor = UIColor.clearColor()
            collectionView?.registerClass(DestinationCollectionCell.self, forCellWithReuseIdentifier: "destinationCollectionCell")
            collectionView?.registerClass(DestinationCollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "destinationCollectionHeader")
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView?.showsVerticalScrollIndicator = false
        }
    }
    
    // 手工设置collectionview
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        collectionView = collectionView ?? UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), collectionViewLayout: layout)
        collectionView!.translatesAutoresizingMaskIntoConstraints = false
//        collectionView!.backgroundColor = UIColor.greenColor()
        self.view.addSubview(collectionView!)
        collectionView!.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Top)    // 设置autoLayout的同时会忽略之前设置的frame
        collectionView!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: searchBar!, withOffset: 10)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let list = DestinationModel.instance.destinationList
        return list.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let list = DestinationModel.instance.destinationList[0]
        return list.count
    }
    
    // 复用cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("destinationCollectionCell", forIndexPath: indexPath) as! DestinationCollectionCell
        cell.delegate = self
        let vo = DestinationModel.instance.destinationList[indexPath.section][indexPath.row]
        cell.setTitle(vo.name)
        cell.setBackgroundImage(vo.pic)
        return cell
    }
    
    // 复用的header或footer
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var supplementaryView: UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "destinationCollectionHeader", forIndexPath: indexPath) as! DestinationCollectionHeader
            let title = DestinationModel.instance.typeList[indexPath.section]
            headerView.setTitle(title)
            supplementaryView = headerView
        }
        return supplementaryView!
    }
    
    // 设置每个cell的大小，可以在这里通过layout统一改变大小，也可以通过delegate的方式单独处理
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionSize = collectionView.frame.size
        let size = CGSize(width: (collectionSize.width - 60) / 2, height: (collectionSize.width - 60) / 2)
        return size
    }
    
    // 最小间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20
    }
    
    // 最小行距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20
    }
    
    // section边距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let list = DestinationModel.instance.destinationList
        if section == 0 {
            return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        }
        if section == list.count - 1 {
            return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        }
        return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
    
    // 设置header大小，如果不设置header将不会出现
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionSize = collectionView.frame.size
        return CGSize(width: collectionSize.width, height: 20)
    }
    
    // 点击某个cell
    func clickCell(destinationName: String) {
        print(destinationName)
        
        detailViewController = detailViewController ?? DestinationDetailController()
        self.navigationController?.pushViewController(detailViewController!, animated: true)
    }
    
    //-------------------------   测试部分   --------------------------
    
    // 测试PureLayout
    func testPureLayout() {
        let view = createView()
        view.backgroundColor = UIColor.greenColor()
        self.view.addSubview(view)
        view.autoSetDimension(ALDimension.Height, toSize: 70.0)
        view.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), excludingEdge: ALEdge.Bottom)
    }
    
    func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
