//
//  MenuViewController.swift
//  study5_1
//
//  Created by 中江洋史 on 2016/11/05.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var datas:Array! = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel!.text = "\(datas[indexPath.row])"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            datas.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func pushAddButton(_ sender: AnyObject) {
        let indexPath = IndexPath(row: datas.count, section: 0)
        datas.append(Date())
        table.insertRows(at: [indexPath], with: .middle)
    }
}
