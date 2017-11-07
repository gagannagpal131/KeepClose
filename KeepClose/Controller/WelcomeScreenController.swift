//
//  WelcomeScreenController.swift
//  KeepClose
//
//  Created by Gagandeep Nagpal on 04/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

class WelcomeScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            
            self.performSegue(withIdentifier: "to_main_menu", sender: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
