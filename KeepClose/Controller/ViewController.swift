//
//  ViewController.swift
//  KeepClose
//
//  Created by Nishant on 05/10/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

var globalBeacon = [Beacon]()

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var beacons = [Beacon]()
    var beaconItems = [BeaconItem]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        tableView.reloadData()
        loadCoreData()
        
        print("GAGAN: \(beacons.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.loadCoreData()
    }
    
    func getBeacon() -> [Beacon] {
        return beacons
    }

    // Load data from Core Data to "beacons".
    func loadCoreData() {
        let fetchRequest: NSFetchRequest<Beacon> = Beacon.fetchRequest()
        
        do {
            beacons = try context.fetch(fetchRequest)
            globalBeacon = beacons
            
            for beacon in beacons {
                let beaconItem = BeaconItem(name: beacon.name!, uuid: beacon.uuid!, majorValue: Int(beacon.major), minorValue: Int(beacon.minor))
                beaconItems.append(beaconItem)
                print("BEACON: startMonitoring called.")
                startMonitoringItem(beaconItem)
            }
            self.tableView.reloadData()
        } catch let error as NSError {
            print("RAO: Cannot fetch data from Core Data - \(error)")
        }
    }
    
    // For monitoring Beacons locaiton.
    func startMonitoringItem(_ beaconItem: BeaconItem) {
        print("BEACON: Inside startMonitoring.")
        let beaconRegion = beaconItem.asBeaconRegion()
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func stopMonitoringItem(_ beaconItem: BeaconItem) {
        let beaconRegion = beaconItem.asBeaconRegion()
        locationManager.stopMonitoring(for: beaconRegion)
        locationManager.stopRangingBeacons(in: beaconRegion)
    }

}

// MARK: Delegate and Data Source for Table View.
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell", for: indexPath) as? BeaconTableViewCell {
            cell.beaconItem = beaconItems[indexPath.row]
            cell.beacon = beacons[indexPath.row]
            return cell
        } else {
            return BeaconTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: Deleagate for Core Location.
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {

        // Find the same beacons in the table.
        var indexPaths = [IndexPath]()
        for beacon in beacons {
            for row in 0..<beaconItems.count {
                if beaconItems[row] == beacon {
                    beaconItems[row].beacon = beacon
                    indexPaths += [IndexPath(row: row, section: 0)]
                }
            }
        }

        // Update beacon locations of visible rows.
        if let visibleRows = tableView.indexPathsForVisibleRows {
            let rowsToUpdate = visibleRows.filter { indexPaths.contains($0) }
            for row in rowsToUpdate {
                let cell = tableView.cellForRow(at: row) as! BeaconTableViewCell
                cell.refreshLocation()
            }
        }
    }
}
