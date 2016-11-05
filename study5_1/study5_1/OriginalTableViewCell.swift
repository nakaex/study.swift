//
//  OriginalTableViewCell.swift
//  study5_1
//
//  Created by 中江洋史 on 2016/11/05.
//  Copyright © 2016年 中江洋史. All rights reserved.
//

import UIKit

class OriginalTableViewCell: UITableViewCell {

    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
