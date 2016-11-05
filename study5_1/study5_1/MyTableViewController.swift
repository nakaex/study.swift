//
//  MyTableViewController.swift
//  study5_1
//
//  Created by 中江洋史 on 2016/11/05.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class MyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:OriginalTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "OriginalCell") as! OriginalTableViewCell
        
//        let leftLabel:UILabel? = cell?.contentView.viewWithTag(10) as? UILabel
//        let centerLabel:UILabel? = cell?.contentView.viewWithTag(11) as? UILabel
//        let rightLabel:UILabel? = cell?.contentView.viewWithTag(12) as? UILabel
        
        cell.leftLabel?.text = "\(indexPath.section)"
        cell.centerLabel?.text = "センター"
        cell.rightLabel?.text = "\(indexPath.row)"
        
        return cell!
    }
}
