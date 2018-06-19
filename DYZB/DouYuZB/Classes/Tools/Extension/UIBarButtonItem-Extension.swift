//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by yx on 2018/6/19.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    // 采用类方法实现
    
    /*
     class func creatItem(imageName: String , highImgName: String ,size: CGSize) ->UIBarButtonItem{
     
     let btn  = UIButton()
     
     btn.setImage(UIImage(named: imageName), for: .normal)
     btn.setImage(UIImage(named: highImgName), for: .highlighted)
     btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
     
     return UIBarButtonItem(customView: btn)
     
     }
     
     */
    
    
    // 采用构造方法实现
    // 便利构造函数的2个要求，
    // 1.以convenience开头。
    // 2. 在构造函数中必须明确调用一个设计的构造函数（self 自己调用）
    
    convenience  init (imageName: String , highImgName: String = "" ,size: CGSize = CGSize(width: 0, height: 0)){
        
        let btn  = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImgName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        self.init(customView :btn)
        
    }
    
}
