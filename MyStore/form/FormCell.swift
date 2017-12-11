//
//  FormCell.swift
//  MyStore
//
//  Created by School on 09/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {
    
    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var storeDescEditText: UITextField!
    @IBOutlet weak var storeAdressTextField: UITextField!

    
    @IBOutlet weak var submitStoreBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FormCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
