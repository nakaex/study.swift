//
//  BaseViewController.swift
//  padtest
//
//  Created by 中江洋史 on 2016/12/11.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationBarAndStatusBarHidden(hidden: Bool, animated: Bool) {
        if let nv = navigationController {
            
            if nv.isNavigationBarHidden == hidden {
                return
            }
            
            let application = UIApplication.shared
            
            if (hidden) {
                // 隠す
                nv.setNavigationBarHidden(hidden, animated: animated)
                application.isStatusBarHidden = hidden
            } else {
                // 表示する
                application.isStatusBarHidden = hidden
                nv.setNavigationBarHidden(hidden, animated: animated)
            }
        }
    }
}
