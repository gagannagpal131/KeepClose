//
//  BeaconTableViewCell.swift
//  KeepClose
//
//  Created by Nishant Yadav on 05/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

class BeaconTableViewCell: UITableViewCell {

    @IBOutlet weak var beaconItemImage: UIImageView!
    @IBOutlet weak var beaconNameLabel: UILabel!
    @IBOutlet weak var beaconLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureBeaconCell(beacon: Beacon, beaconItem: BeaconItem) {
        
        beaconItemImage.image = beacon.image as? UIImage
        beaconNameLabel.text = beacon.name
        beaconLocationLabel.text = beaconItem.locationString()
    }
}
