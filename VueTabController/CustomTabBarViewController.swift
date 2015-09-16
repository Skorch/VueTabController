//
//  MatchesTabBarViewController.swift
//  burstprototype
//
//  Created by Drew Beaupre on 2015-09-15.
//  Copyright © 2015 Glass 10. All rights reserved.
//

import UIKit

class CustomTabBarViewController: VueTabBarViewController {
   
    var swipeLeftGestureRecognizer: UISwipeGestureRecognizer!
    var swipeRightGestureRecognizer: UISwipeGestureRecognizer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("viewSwiped:"))
        swipeLeftGestureRecognizer.direction = .Left
        contentView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("viewSwiped:"))
        swipeRightGestureRecognizer.direction = .Right
        contentView.addGestureRecognizer(swipeRightGestureRecognizer)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Custom prepare for segue stuff
        
        super.prepareForSegue(segue, sender: sender)

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {

        //custom checks for performing segue
        
        return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
    }
    
    func viewSwiped(gesture: UISwipeGestureRecognizer){
        
        let activeViewControllerIndex = self.activeViewControllerIndex ?? 0
        
        var nextIndex: Int!
        
        switch gesture.direction{
        case UISwipeGestureRecognizerDirection.Left:
            
            nextIndex = (activeViewControllerIndex == 0) ? tabBarButtons.count - 1 : activeViewControllerIndex - 1
            
            break
        case UISwipeGestureRecognizerDirection.Right:
            
            nextIndex = (activeViewControllerIndex == tabBarButtons.count - 1) ? 0 : activeViewControllerIndex + 1
            
            break
        default:
            print("Wrong swipe direction detected.  Doing nothing.")
            return
        }
        
        tabBarButtons[nextIndex].sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        
    }
}
