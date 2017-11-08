//
//  CustomImageView.swift
//  KeepClose
//
//  Created by Nishant Yadav on 05/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2.0
        layer.cornerRadius = 20.0
        clipsToBounds = true
    }
}
