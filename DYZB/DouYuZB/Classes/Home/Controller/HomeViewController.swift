//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by yx on 2018/6/19.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40


class HomeViewController: UIViewController {
    
    // 懒加载属性
    
  lazy  private  var pageTitleView : PageTitleView = {
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenWidth, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
        
        return titleView
        
    }()
    
    private lazy var pageContenView : PageContentView = { [weak self] in
       
        // 1. 确定内容的frame
        let contenH = kScreenHeigh - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenWidth, height: contenH)
        
        // 2. 确定所有的子控制器
        var childVcs = [UIViewController] ()
        
        for _ in 0 ..< 4 {
            let vc  = UIViewController()
            
            vc.view.backgroundColor = UIColor(r: CGFloat (arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
        }
        
        let contenView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contenView.delegate = self
        return contenView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        
        
        
    }
    
}

extension HomeViewController {
    
    private func setupUI(){
        
        // 不需要调整UIScrollview的内边距
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2. 添加TitleView
        view.addSubview(pageTitleView)
        
        // 3. 添加contenview
        
        view.addSubview(pageContenView)
//        pageContenView.backgroundColor = UIColor.yellow
    }
    
    private func setupNavigationBar() {
        // 1.设置左侧的导航栏
        /*
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "logo"), for: .normal)
        //        leftBtn.setImage(UIImage(named: "logo"), for: .highlighted)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        */
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        // 2.设置右侧的导航栏
        /*
         let size = CGSize(width: 40, height: 40)
         
         
         let historyBtn = UIButton()
         historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
         historyBtn.setImage(UIImage(named: "image_my_history_clicked"), for: .highlighted)
         //        historyBtn.sizeToFit()
         historyBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0) , size: size)
         let searchBtn = UIButton()
         searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
         searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
         //        searchBtn.sizeToFit()
         searchBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0) , size: size)
         
         let qrcodeBtn = UIButton()
         qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
         qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
         //        qrcodeBtn.sizeToFit()
         qrcodeBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0) , size: size)
         
         let historyItem = UIBarButtonItem(customView: historyBtn)
         let searchItem  = UIBarButtonItem(customView: searchBtn)
         let qrcodeItem  = UIBarButtonItem(customView: qrcodeBtn)
         
         
         navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
         
         */
        
        // 使用类方法实现
        /*
         let size = CGSize(width: 40, height: 40)
         
         let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highImgName: "image_my_history_clicked", size: size)
         let searchItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImgName: "btn_search_clicked", size: size)
         let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImgName: "Image_scan_click", size: size)
         
         navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
         
         */
        
        // 使用构造方法实现
        
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImgName: "image_my_history_clicked", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImgName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImgName: "Image_scan_click", size: size)
        
//        let test  = UIBarButtonItem(imageName: <#T##String#>)
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    
}

// MARK -- 遵守PageTitleViewDelegate

extension HomeViewController : PageTitleViewDelegate     {

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {

        pageContenView.setupCurrentIndex(currentIndex: index)
    }

}

// 遵守PageContentVIewDelegate

extension HomeViewController : PageContentViewDelegate {
    
    func pageContentView(contenView: PageContentView, progress: CGFloat, sources: Int, target: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, sourcesIndex: sources, targetIndex: target)
    }
    
}




