//
//  StoreCell.swift
//  MyStore
//
//  Created by School on 10/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var StoreDescriptionLabel: UILabel!
    @IBOutlet weak var storeAddressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
}
