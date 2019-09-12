//
//  TransformerCell.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-11.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import UIKit

class TransformerCell: UITableViewCell {

    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var transformers: TransformerViewModel! {
        didSet {
            name.text = transformers.tvm.name
            teamIcon.loadImageUsingCacheWithURLString(urlString: transformers.tvm.team_icon)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
