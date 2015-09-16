//
//  BurstTabBarSegue.swift
//  burstprototype
//
//  Created by Drew Beaupre on 2015-09-14.
//  Copyright © 2015 Glass 10. All rights reserved.
//

import UIKit

class VueTabBarSegue: UIStoryboardSegue {
    
    weak var cachedViewController: UIViewController?
    
    override func perform() {
        
        guard let tabController = self.sourceViewController as? VueTabBarViewController else{
            return assertionFailure("Segue source is not Burst Tab Bar controller")
        }

        let contentController = cachedViewController ?? self.destinationViewController
        
        if let currentViewController = tabController.currentViewController{
            
            currentViewController.willMoveToParentViewController(nil)
            currentViewController.view.removeFromSuperview()
            currentViewController.removeFromParentViewController()
        }
        
        tabController.currentViewController = contentController
        tabController.addChildViewController(contentController)
        contentController.view.frame = tabController.contentView.bounds
        tabController.contentView.addSubview(contentController.view)
        contentController.didMoveToParentViewController(tabController)
    }

}
