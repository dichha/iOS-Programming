//
//  ViewController.swift
//  Psychologist
//
//  Created by raidi01 on 3/9/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    //code way of seguing (target and action)
    //reason to do this: on button click doing one segue vs another segue if then statement (classic reason)
    
    @IBAction func nothing(sender: UIButton) {
        //causing a segue to happen, nothing segue was from psychologistViewController to navigationBar was made using user interface and named it "nothing" in attribute inspector
        
        performSegueWithIdentifier("nothing", sender: self)//sender can be nil, self or button
        
        
    }
    
    

    //prepare statement
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //this function since we have added UINavigationController and needs a segue to HappinessViewController
        var destination = segue.destinationViewController as? UIViewController
        
        //this statement is prepared if there is both UINavigationViewController or HappinessViewController
        // if UInavigationController is present (HappinessViewController is wrapped in UINavigationViewController) then this statement carries out else
        if let navCon = destination as? UINavigationController{
            //making it to be visible which is on top of stack
            destination = navCon.visibleViewController
        }
        //this one carries out
        if let hvc = destination as? HappinessViewController{
            if let identifier = segue.identifier{
                switch identifier {
                    case "sad": hvc.happiness = 0
                    case "happy": hvc.happiness = 100
                    case "nothing": hvc.happiness = 25
                    default: hvc.happiness = 50
                    
                }
            }
        }
    }
}

