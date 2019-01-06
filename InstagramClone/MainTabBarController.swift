//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/6/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .red
        
        let blueVC = UIViewController()
        blueVC.view.backgroundColor = .blue
        
        let layout = UICollectionViewFlowLayout()
        let userProfileVC = UserProfileViewController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileVC)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected").withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected").withRenderingMode(.alwaysOriginal)
        
        viewControllers = [navController, UIViewController()]
    }
}
