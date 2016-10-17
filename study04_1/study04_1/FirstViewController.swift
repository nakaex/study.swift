//
//  FirstViewController.swift
//  study04_1
//
//  Created by 中江洋史 on 2016/10/15.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let arrayA = ["A1","A2","A3"]
    let arrayK = ["K1","K2","K3"]
    let arrayS = ["S1","S2","S3"]
    let arrayAll = [["あ":["A1","A2","A3","A4","A5","A6"]],["兼元":["K1","K2","K3","K4","KKKKK"]],["かねもと":["K1","K2","K3"]],["さ":["S1","S2","S3"]]]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(arrayAll)
        print(arrayAll[0].values.first?.count)
        print(arrayAll[1])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrayAll[section].values.first?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayAll.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayAll[section].keys.first
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        var val: Array<String>? = arrayAll[indexPath.section].values.first
        cell?.textLabel?.text = val?[indexPath.row]
        //cell?.accessoryType = UITableViewCellAccessoryType.checkmark

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.section) \(indexPath.row)")
        var val: Array<String>? = arrayAll[indexPath.section].values.first
        let text = val?[indexPath.row]
        
        performSegue(withIdentifier: "secondViewController", sender: text)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="secondViewController") {
            let str = sender as! String
            let vc:SecondViewController = segue.destination as! SecondViewController
            vc.labelStr = str
        }
    }
}
