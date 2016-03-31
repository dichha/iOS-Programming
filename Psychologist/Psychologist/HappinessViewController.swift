//
//  HappinessViewController.swift
//  Happiness
//
//  Created by raidi01 on 3/7/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    var happiness: Int = 100 {
        // 0 = very sad, 100 = ecstatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            print("happiness is \(happiness)")
            updateUI()
        }
    }
    
    func updateUI(){
        //? because if faceView is null do nothing
        faceView?.setNeedsDisplay()
        //title for happinessDiagnosis face
        title = "\(happiness)"
    }
    //Change in 4 points = 1
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    
    //Controller is interpreting change in view for model. That's the job of controller interpeting model for view and view for model
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state{
        case .Ended: fallthrough
        case .Changed:
            //getting the change in pan in faceView's coordinate system
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            
            if happinessChange != 0{
                happiness += happinessChange
                //resetting to Zero after every change
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
            
        }
        
    }
    
    
    @IBOutlet weak var faceView: FaceView!{
        //property observer
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            //This way is perfectly correct
            //faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness"))
            
        }
    }
    
  
    func smilinessForFaceView(sender: FaceView) -> Double? {
        //return model for view (controller's job)
        return Double(happiness-50)/50
    }

}
