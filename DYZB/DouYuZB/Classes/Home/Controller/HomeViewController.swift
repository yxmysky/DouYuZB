//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by yx on 2018/6/19.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        
        
        
    }
}

extension HomeViewController {
    
    private func setupUI(){
        // 1.设置导航栏
        setupNavigationBar()
                
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
