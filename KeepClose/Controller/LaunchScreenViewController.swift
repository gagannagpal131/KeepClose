//
//  LaunchScreenViewController.swift
//  KeepClose
//
//  Created by Nishant Yadav on 10/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.launchAnimation()
        _ = Timer.scheduledTimer(withTimeInterval: 2.6, repeats: false) { (timer) in
            
            self.performSegue(withIdentifier: "WelcomeViewController", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func launchAnimation() {
        
        let animationView = LOTAnimationView(name: "plane")
        animationView.frame = CGRect(x: 20.0, y: 100.0, width: 335.0, height: 300.0)
        animationView.contentMode = .scaleAspectFit
        
        self.view.addSubview(animationView)
        
        animationView.play()
        animationView.loopAnimation = true
    }
}
