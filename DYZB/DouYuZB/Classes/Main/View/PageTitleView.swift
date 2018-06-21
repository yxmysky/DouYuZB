//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by yx on 2018/6/20.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

// 定义协议
protocol PageTitleViewDelegate : class {
    
    func pageTitleView (titleView : PageTitleView , selectedIndex index : Int)
    
}

// 定义常量

private let kscrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat ,CGFloat ,CGFloat) = (255,128,0)

// 定义pageTitle；类

class PageTitleView: UIView {

    // 定义属性
    fileprivate var titles : [String]
    private var currentIndex : Int = 0
    
    weak var delegate : PageTitleViewDelegate?
    
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3. 设置label的frame
            let labeX : CGFloat = labeW * (CGFloat)(index)


            label.frame = CGRect(x: labeX, y: labeY, width: labeW, height: labeH)
            
            // 4. 将label 添加到scrollview中
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5. 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
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

// MARK -- 监听Labell 的点击事件

extension PageTitleView {
    
    @objc private func titleLabelClick(tapGes :UITapGestureRecognizer ){
        
        // 1. 获取当前的label的下标值
        guard   let currentLabel = tapGes.view as? UILabel else {return}
        
        // 2. 获取之前的label值
        let oldLbel = titleLabels[currentIndex]
        // 3.切换文字的颜色
        oldLbel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        // 4.保存最新的label值
        currentIndex = currentLabel.tag
        
        // 5. 滚动条位置发生改变
        
        let scrollLineX =  CGFloat( currentLabel.tag ) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x   = scrollLineX
        }
        
        // 6. 通知代理做事情
        
        delegate?.pageTitleView( titleView: self, selectedIndex: currentIndex)
        
        
    }
    
}

//MARK -- 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(progress : CGFloat , sourcesIndex : Int , targetIndex :  Int) {
        // 1. 取出sources /targetLabel
        
        let sourceLabel = titleLabels[sourcesIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2. 处理滑块的逻辑
        let moveTotalX =  targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x  = sourceLabel.frame.origin.x + moveX
        
        // 3. 让label颜色发生渐变
        // a。取出变化范围
        let colorDelta  = ( kSelectedColor.0 - kNormalColor.0 , kSelectedColor.1 - kNormalColor.1 , kSelectedColor.2 - kNormalColor.2 )
        // b.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress , g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        
        // c.变化targetLabel
        targetLabel.textColor  = UIColor(r: kNormalColor.0 + colorDelta.0 * progress , g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        
        
    }
}




