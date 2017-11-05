//
//  AddBeaconViewController.swift
//  KeepClose
//
//  Created by Gagandeep Nagpal on 04/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import CoreData

class AddBeaconViewController: UIViewController {
    
    @IBOutlet weak var beaconImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var minorTextField: UITextField!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        tap.numberOfTapsRequired = 2
        beaconImage.addGestureRecognizer(tap)
        beaconImage.isUserInteractionEnabled = true
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
    
    @objc func selectImage() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Save beacon data to Core Data.
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        var beacon: Beacon!
        beacon = Beacon(context: context)
        
        if let image = beaconImage.image, imageSelected == true {
            beacon.image = image
            imageSelected = false
        }
        
        if let name = nameTextField.text, name != "" {
            beacon.name = name
        }
        
        if let uuid = uuidTextField.text {
            beacon.uuid = uuid
        }
        
        if let major = majorTextField.text, major != "" {
            beacon.major = (major as NSString).intValue
        }
        
        if let minor = minorTextField.text, minor != "" {
            beacon.minor = (minor as NSString).intValue
        }
        
        do {
            try context.save()
            print("RAO: Data added to Core Data.")
        } catch let error as NSError {
            print("RAO: Could not save data. \(error), \(error.userInfo)")
        }
        
        navigationController?.popViewController(animated: true)
    }
}

// Extension for UIImagePickerView.
extension AddBeaconViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            beaconImage.image = image
            imageSelected = true
            print("NEWRAO: A valid image is  selected.")
        } else {
            print("NEWRAO: A valid image is not selected.")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
