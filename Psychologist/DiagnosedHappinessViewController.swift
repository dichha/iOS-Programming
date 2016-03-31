//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by raidi01 on 3/10/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit
class DiagnosedHappinessViewController:HappinessViewController, UIPopoverPresentationControllerDelegate{
    
    //all the segues that is created when any of the ansewers in psychologist's viewController is pressed new mvc is generated everytime so dignoticHistory only have present happiness. so to remember we use NSuserDeafault
    
    //var diagnosticHistory = [Int]()//stored property
    
    
    private let defaults = NSUserDefaults.standardUserDefaults()//shared version of NSUserDefaults. The whole app is going to share it and use it to read and write
    
    //computed property
    var diagnosticHistory: [Int] {
        get{
            return defaults.objectForKey(History.Defaultskey) as? [Int] ?? []//since defaults will always be an array of key else returns an empty array
        }
        set{
            defaults.setObject(newValue, forKey: History.Defaultskey)
        }
    }
    
    
    
    override var happiness: Int{
        //does not override superclass (HappinessViewController's ) didSet property observer. It first sets for super class an comes here
        didSet{
            diagnosticHistory += [happiness]
        }
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        //defauts key for history
        static let Defaultskey = "DiagnosedHappinessViewController.History"
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //preparing for seguing to TextViewController
        if let identifier = segue.identifier{
            switch identifier{
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController{
                    
                    if let ppc = tvc.popoverPresentationController{
                        ppc.delegate = self //allows someone to control over how the presentation works.
                    }
                    tvc.text = "\(diagnosticHistory)"
                    
                }
                default: break
            }
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
}
