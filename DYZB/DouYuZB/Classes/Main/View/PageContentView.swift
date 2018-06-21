//
//  PageContentView.swift
//  DouYuZB
//
//  Created by yx on 2018/6/20.
//  Copyright © 2018年 swift. All rights reserved.
//

// 修改。。。 b
import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contenView : PageContentView , progress : CGFloat , sources  : Int , target : Int)
}

private let ContentCellID = "ContentCellID"



class PageContentView: UIView {

    // 定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    
    // 懒加载属性
    
    private lazy var collectionView : UICollectionView = { [weak self] in
        
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建collectionview
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        
        return collectionView
        
    }()
    
    // MARK -- 自定义构造函数
    init(frame: CGRect ,childVcs : [UIViewController] ,parentViewController : UIViewController?) {
        
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
            parentViewController?.addChildViewController(childVc)
        }
        
        // 2. 添加collectionview 用于在cell 中存放时图控制器的view
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}



// MARK -- 实现CollecTionViewDataSources

extension PageContentView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return childVcs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 创建cell
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        // 2. 给cell设置内容
        let childVc = childVcs [indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
    }
    
}

// 遵循UICollectionViewDelegate

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 定义获取滚动的信息
        var progress : CGFloat = 0
        var sourcesIndex : Int = 0
        var targetIndex : Int  = 0
        
        // 2. 判断滑动方向
        let curretOffsetX  = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        
        if curretOffsetX > startOffsetX {
            // 左滑
            // 1. 计算progress
            progress = curretOffsetX / scrollViewW - floor(curretOffsetX / scrollViewW)
            
            // 2. 计算sourcesIndex
            sourcesIndex = Int (curretOffsetX / scrollViewW)
            
            // 3. 计算targetIndex
            targetIndex = sourcesIndex + 1
            if targetIndex >= childVcs.count {
                
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全滑过去
            
            if curretOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourcesIndex
            }
            
        }else{
            // 右滑
            
            // 1. 计算progress
            progress = 1 - (curretOffsetX / scrollViewW - floor(curretOffsetX / scrollViewW))
            
            // 2. 计算sources
            sourcesIndex = 1 +  Int (curretOffsetX / scrollViewW)
            if sourcesIndex >= childVcs.count{
                
                sourcesIndex = childVcs.count - 1
            }
            
            
            // 3. 计算targetIndex
            targetIndex = Int (curretOffsetX / scrollViewW)
            
            
        }
        
        
        // 3.将progress/sources/targetIndex 传输给titleView
        
        delegate?.pageContentView(contenView: self, progress: progress, sources: sourcesIndex, target: targetIndex)
    

        
    }
    
    
}


// MARK--对外暴露的方法

extension PageContentView {
    
    func setupCurrentIndex(currentIndex : Int) {
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
    
}





