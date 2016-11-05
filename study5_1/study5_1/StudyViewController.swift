//
//  StudyViewController.swift
//  study5_1
//
//  Created by 中江洋史 on 2016/11/05.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellMax:Int = 100

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellMax
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index:Int = indexPath.row
        let cell:UITableViewCell!
        
        if index%2 == 1 {
            let cellImage:OriginalImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OriginalImageCell") as! OriginalImageTableViewCell
            cell = cellImage
        }
        else {
            let cellLabel:OriginalLabelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OriginalLabelCell") as! OriginalLabelTableViewCell
            cellLabel.centerLabel.text = "\(index)"
            cell = cellLabel
        }
        
        return cell!
    }
}
