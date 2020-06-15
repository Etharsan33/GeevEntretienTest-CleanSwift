//
//  TabBarController.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func setupViews() {
            let donationVC = DonationsViewController.instanceCS
            donationVC.title = GEEVLoc.Tab.TAB_DONATION.localized
            let donationNVC = UINavigationController(rootViewController: donationVC)
            donationNVC.tabBarItem = UITabBarItem(title: GEEVLoc.Tab.TAB_DONATION.localized, image: #imageLiteral(resourceName: "tab_donation"), tag: 0)
            
            let creationVC = UIViewController()
            let creationNVC = UINavigationController(rootViewController: creationVC)
            creationNVC.tabBarItem = UITabBarItem(title: GEEVLoc.Tab.TAB_CREATION.localized, image: #imageLiteral(resourceName: "tab_creation"), tag: 1)
            
            let messagesVC = UIViewController()
            let messagesNVC = UINavigationController(rootViewController: messagesVC)
            messagesNVC.tabBarItem = UITabBarItem(title: GEEVLoc.Tab.TAB_MESSAGES.localized, image: #imageLiteral(resourceName: "tab_messages"), tag: 2)
            
            let profileVC = UIViewController()
            let profileNVC = UINavigationController(rootViewController: profileVC)
            profileNVC.tabBarItem = UITabBarItem(title: GEEVLoc.Tab.TAB_PROFILE.localized, image: #imageLiteral(resourceName: "tab_profil"), tag: 3)
            
            self.viewControllers = [donationNVC, creationNVC, messagesNVC, profileNVC]
        }
        
        setupViews()
    }
}
