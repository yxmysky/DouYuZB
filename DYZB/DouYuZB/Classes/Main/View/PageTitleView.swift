//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by yx on 2018/6/20.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

private let kscrollLineH : CGFloat = 2


class PageTitleView: UIView {

    // 定义属性
    fileprivate var titles : [String]
    
    // MARK-- 懒加载属性
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    // MARK: -- 自定义构造函数
    

    init(frame: CGRect ,titles : [String] ) {
        
        self.titles = titles
        super.init(frame:frame)

        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

 // MARK -- 设置UI界面

extension PageTitleView {
    
    private func setupUI() {
        
        // 1. 添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加title 对应的label
        seupTitleLabels()
        
        // 3. 设置scrollviewLine的滑块
        
        setupScrollViewLine()
        
    }
    
    private func seupTitleLabels(){
        
        // 确定一些Frame的值
        
        let labeW : CGFloat = frame.width / CGFloat (titles.count)
        let labeH : CGFloat = frame.height - kscrollLineH
        let labeY : CGFloat = 0
        
        for (index ,title) in titles.enumerated() {
            
            // 1. 创建label
            let label = UILabel()
            
            // 2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 3. 设置label的frame
            let labeX : CGFloat = labeW * (CGFloat)(index)


            label.frame = CGRect(x: labeX, y: labeY, width: labeW, height: labeH)
            
            // 4. 将label 添加到scrollview中
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
        
    }
    
    private func setupScrollViewLine() {
        
        //1. 添加底线
        let bottomLine = UIView()
        let lineH : CGFloat  = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        // 2.2 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kscrollLineH, width: firstLabel.frame.width, height: kscrollLineH)
        
    }
    
}
