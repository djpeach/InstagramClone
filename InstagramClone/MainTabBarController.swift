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
        
        // MARK: Collection View Creation
        // Create a layout to that the Collection view will use.
        // This will determine things such as the supplementary views the CV can use
        //     In the case of UICollectionViewFlowLayout, the supp views are a header and/or footer.
        let layout = UICollectionViewFlowLayout()
        // Create a VC from our custom ColViewVC
        let userProfileVC = UserProfileViewController(collectionViewLayout: layout)
        
        // Set that VC as the rootVC of our navController
        let navController = UINavigationController(rootViewController: userProfileVC)
        
        // The tabBar of the VC will be used when added to a tab bar controller
        // In our case, the VC we are in is a UITabBarController, so it is used now
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected").withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected").withRenderingMode(.alwaysOriginal)
        
        // This is where we set the stack of ViewControllers on the navigation stack
        viewControllers = [navController]
    }
}
