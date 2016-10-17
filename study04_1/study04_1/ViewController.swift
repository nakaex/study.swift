//
//  ViewController.swift
//  study04_1
//
//  Created by 中江洋史 on 2016/10/15.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        simpleMethod()
        
        let str = returnValueMethod()
        print("文字列: " + str)
        
        oneArgumentMethod(hoge: "moji")
        
        twoArgumentMethod(hoge: "hoge", fuga: "fuga")
        
        defaultValueArgument(hoge: "初期値")
        defaultValueArgument()
        
        defaultValueArgument2(fuga: 50)
        defaultValueArgument2(hoge: "hoge", fuga: 10)
        
        print(testValueArgument3(1));
        print(testValueArgument3(2));
        print(testValueArgument3(100));
        
        let stepper: UIStepper? = self.view.viewWithTag(1) as! UIStepper?
        stepper?.minimumValue = 5.0
        stepper?.maximumValue = 20.0
        stepper?.addTarget(self, action: #selector(ViewController.stepperValueChanged2), for: .valueChanged)

        let stepper2: UIStepper? = self.view.viewWithTag(2) as! UIStepper?
        stepper2?.minimumValue = 5.0
        stepper2?.maximumValue = 20.0
        stepper2?.addTarget(self, action: #selector(ViewController.stepperValueChanged2), for: .valueChanged)
    }
    
    func stepperValueChanged2(sender: UIStepper) {
        if (sender.tag == 1) {
            let label1: UILabel? = self.view.viewWithTag(10) as! UILabel?
            label1?.text = "\(sender.value)"
        }
        else {
            let label2: UILabel? = self.view.viewWithTag(20) as! UILabel?
            label2?.text = "\(sender.value)"
        }
        
        print("value \(sender.value)")
    }
    
    func simpleMethod() {
        print("引数も戻り値もないメソッド")
    }

    func returnValueMethod() -> String {
        return "文字列を返す"
    }

    func oneArgumentMethod(hoge: String) {
        print("引数が一つ存在するメソッド: " + hoge)
    }
    
    func twoArgumentMethod(hoge: String, fuga: String) {
        print("引数が二つ存在するメソッド: " + hoge + fuga )
    }
    
    func defaultValueArgument(hoge: String = "メッセージなし") {
        print("引数に初期値を設定したメソッド: " + hoge)
    }
    
    func defaultValueArgument2(hoge: String = "メッセージなし", fuga: Int) {
        print("引数に初期値を設定したメソッド2: " + hoge)
    }
    
    func testValueArgument3(_ intval: Int) -> String {
        return (intval%2) == 0 ? "偶数" : "奇数"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print("\(sender.value)")
    }

}

