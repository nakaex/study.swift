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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print("\(sender.value)")
    }

}

