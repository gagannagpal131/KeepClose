//
//  WelcomeScreenController.swift
//  KeepClose
//
//  Created by Gagandeep Nagpal on 04/11/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import PaperOnboarding

class WelcomeScreenController: UIViewController,PaperOnboardingDataSource, PaperOnboardingDelegate {

    @IBOutlet weak var onboardingView: OnboardingView!
    
    
    
    @IBOutlet weak var getStartedBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    
    
    
    
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 0.7)

        let titleFont = UIFont(name: "AvenirNext-Bold", size: 22)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 19)!
        
        return [(imageName: #imageLiteral(resourceName: "Group-1"), title: "Worried about luggage theft?", description: "Just put the beacon inside the suitcase or your laptop bag to keep it safe from theft. No more constant worrying!", iconName: #imageLiteral(resourceName: "Oval"), color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
                
                (imageName: #imageLiteral(resourceName: "Group-3"), title: "Get Instant Alerts!", description: "Your iPhone will notify you as soon as your item goes beyond a certain range from you. Make sure to turn on your iPhone’s Bluetooth.", iconName: #imageLiteral(resourceName: "Oval"), color: backgroundColorTwo, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
                
                (imageName: #imageLiteral(resourceName: "Group"), title: "We have your Back!", description: "KeepClose makes use of BLE technology to keep an eye on your luggage for you. Now travel with one less worry and let us do the worrying for you.", iconName: #imageLiteral(resourceName: "Oval"), color: backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)][index]
    }
    
    
    @objc func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1{
            
            if self.getStartedBtn.alpha == 1{
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedBtn.alpha = 0
                })
            }
            
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2{
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedBtn.alpha = 1
            })
        }
    }
    
}


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

