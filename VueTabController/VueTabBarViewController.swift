//
//  BurstTabBarViewController.swift
//  burstprototype
//
//  Created by Drew Beaupre on 2015-09-14.
//  Copyright © 2015 Glass 10. All rights reserved.
//

import UIKit

class VueTabBarViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var activeIndicatorView: UIView!
    @IBOutlet weak var activeIndicatorLeadingContraint: NSLayoutConstraint!
    @IBOutlet var tabBarButtons: [UIButton]!
    
    var activeViewControllerIndex: Int?
    var viewControllers = [String:UIViewController]()
    var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        if self.viewControllers.count == 0{
            
            tabBarButtons[0].sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        //TODO:  notify view controller that it was re-selected.  Provides the opportunity for that view controller to reset itself
        
        guard   let index = activeViewControllerIndex,
                let button = sender as? UIButton
            else{
                return true
        }
        
        return (tabBarButtons.indexOf(button) ?? -1) != index
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        guard let identifier = segue.identifier else{
            
            return assertionFailure("Custom Tab Bar segue must have an identifier.")
        }
        
        guard let senderValue = sender as? UIButton else{
            
            return assertionFailure("Sender must be set and be a UIButton.")
        }
        
        if let tabSegue = segue as? VueTabBarSegue{
            
            let destinationViewController = segue.destinationViewController
            
            if !viewControllers.keys.contains(identifier){
                
                viewControllers[identifier] = destinationViewController
            }
            
            tabSegue.cachedViewController = viewControllers[identifier]
            
            if let index = self.tabBarButtons.indexOf(senderValue){
                
                setActiveIndicatorViewToIndex(index, animated:true)
            }
            
        }

    }
    
    private func setActiveIndicatorViewToIndex(index: Int, animated: Bool){
        
        for (buttonIndex, button) in self.tabBarButtons.enumerate(){
            
            let color = (buttonIndex == index) ? self.view.tintColor : UIColor.grayColor()
            
            button.tintColor = color
        }
        
        activeViewControllerIndex = index

        let filteredItems = tabBarButtons[0...index]
        
        let newX = filteredItems.last?.frame.minX ?? 0.0
        
        self.activeIndicatorLeadingContraint.constant = newX

        if animated {
            
            UIView.animateWithDuration(0.2,
            
            delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
                self.view.layoutIfNeeded()
                
            }, completion: nil)

        }
    }
    

}
