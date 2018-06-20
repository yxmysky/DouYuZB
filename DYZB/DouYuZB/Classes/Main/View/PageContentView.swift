//
//  PageContentView.swift
//  DouYuZB
//
//  Created by yx on 2018/6/20.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class PageContentView: UIView {

    // 定义属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    
    // 懒加载属性
    
    private lazy var collectionView : UICollectionView = {
       
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建collectionview
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        return collectionView
        
    }()
    
    // MARK -- 自定义构造函数
    init(frame: CGRect ,childVcs : [UIViewController] ,parentViewController : UIViewController) {
        
        self.parentViewController = parentViewController
        self.childVcs = childVcs
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}


// MARK -- 设置UI界面
extension PageContentView {
    
    private func setupUI(){
        
        // 1. 将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController.addChildViewController(childVc)
        }
        
        // 2. 添加collectionview 用于在cell 中存放时图控制器的view
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}
