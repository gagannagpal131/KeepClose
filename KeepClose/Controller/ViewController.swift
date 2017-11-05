//
//  ViewController.swift
//  KeepClose
//
//  Created by Nishant on 05/10/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var beacons = [Beacon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.loadData()
    }

    // Load data from Core Data to "beacons".
    func loadData() {
        let fetchRequest: NSFetchRequest<Beacon> = Beacon.fetchRequest()
        
        do {
            beacons = try context.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("RAO: Cannot fetch data from Core Data - \(error)")
        }
    }
}

// Extension for UITableView.
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell", for: indexPath) as? BeaconTableViewCell {
            cell.configureBeaconCell(beacon: beacons[indexPath.row])
            return cell
        } else {
            return BeaconTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
