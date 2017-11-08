//
//  CustomTextField.swift
//  KeepClose
//
//  Created by Nishant Yadav on 05/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 1.0
    }
}
