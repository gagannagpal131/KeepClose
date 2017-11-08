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
    
//    func configureBeaconCell(beacon: Beacon, beaconItem: BeaconItem) {
//
//        print("NEWBEACON: \(beaconItem.name)")
//        beaconItemImage.image = beacon.image as? UIImage
//        beaconNameLabel.text = beacon.name
//        beaconLocationLabel.text = beaconItem.locationString()
//        print("BEACON: Inside configureBeaconCell")
//    }
    
    var beaconItem: BeaconItem? = nil {
        didSet {
            if let beaconItem = beaconItem {
                beaconNameLabel.text = beaconItem.name
                print("RAO: \(beaconItem.uuid)")
                beaconLocationLabel.text = beaconItem.locationString()
            } else {
                beaconNameLabel.text = ""
                beaconLocationLabel.text = ""
            }
        }
    }
    
    var beacon: Beacon? = nil {
        didSet {
            if let beacon = beacon {
                beaconItemImage.image = beacon.image as? UIImage
            } else {
                beaconItemImage.image = UIImage()
            }
        }
    }
    
    func refreshLocation() {
        beaconLocationLabel.text = beaconItem?.locationString() ?? ""
    }
}
