//
//  BeaconItem.swift
//  KeepClose
//
//  Created by Nishant Yadav on 06/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class BeaconItem  {
    
    let name: String
    let uuid: UUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    var beacon: CLBeacon?
    
    init(name: String, uuid: UUID, majorValue: Int, minorValue: Int) {
        print("BEACON: In BeaconItem.")
        self.name = name
        self.uuid = uuid
        self.majorValue = CLBeaconMajorValue(majorValue)
        self.minorValue = CLBeaconMinorValue(minorValue)
    }
    
    func asBeaconRegion() -> CLBeaconRegion {
        print("REGION: Region created.")
        return CLBeaconRegion(proximityUUID: uuid, major: majorValue, minor: minorValue, identifier: name)
    }
    
    func locationString() -> String {
        print("BEACON: locationString called.")
        guard let beacon = beacon else { return "Proximity: Unknown" }
        let proximity = nameForProximity(beacon.proximity)
        print("PROXIMITY: \(proximity)")
//        let accuracy = String(format: "%.2f", beacon.accuracy)
        
        let location = "Proximity: \(proximity)"
//        if beacon.proximity != .unknown {
//            location += " (approx. \(accuracy)m)"
//        }
        print("BEACON: \(location)")
        return location
    }
    
    func nameForProximity(_ proximity: CLProximity) -> String {
        switch proximity {
        case .unknown:
            return "Unknown"
        case .immediate:
            return "Immediate"
        case .near:
            return "Near"
        case .far:
            return "Far"
        }
    }
}

func ==(beaconItem: BeaconItem, beacon: CLBeacon) -> Bool {
    return ((beacon.proximityUUID.uuidString == beaconItem.uuid.uuidString)
        && (Int(truncating: beacon.major) == Int(beaconItem.majorValue))
        && (Int(truncating: beacon.minor) == Int(beaconItem.minorValue)))
}
