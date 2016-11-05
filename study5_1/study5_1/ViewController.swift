//
//  ViewController.swift
//  study5_1
//
//  Created by 中江洋史 on 2016/11/05.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image = UIImage(named: "yahoologo")
        
        let fram:CGRect = CGRect(x:10, y: 20, width: 50, height: 75)
        let view:UIView = UIView(frame: fram)
        
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.purple.cgColor
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 10, height: 15)
        view.layer.shadowColor = UIColor.blue.cgColor
        
        self.view.addSubview(view)
        
        let size:Int = 100
        let maruFram:CGRect = CGRect(x:10, y:150, width: size, height: size)
        let maruView:UIView = UIView(frame: maruFram)
        
        maruView.backgroundColor = UIColor.brown
        maruView.layer.cornerRadius = maruView.frame.width / 2
        
        self.view.addSubview(maruView)
        
        var array = ["りんご","バナナ","ぶどう"]
        print("array = \(array)")
        print(array[0])
        
        array.insert("ぶどう", at: 1)
        print("array = \(array)")
        
        array.insert("イチゴ", at: array.count)
        print("array = \(array)")
        
        array.remove(at: 0)
        print("array = \(array)")

        print("array count = \(array.count)")
        
        var dic = ["name":"Swiftマン","age":"20","address":"Aichi"]
        print("dic = \(dic)")
        print("名前 \(dic["name"]!)")
        
        dic["hobby"] = "散歩"
        print("趣味 \(dic["hobby"]!)")
        
        dic.removeValue(forKey: "address")
        print("dic = \(dic)")
        
        let allKeys = Array(dic.keys)
        print("キー： \(allKeys)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
