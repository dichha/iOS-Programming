//
//  DropitViewController.swift
//  Dropit
//
//  Created by raidi01 on 4/19/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate
{
    //outlet for containing dropit game
    @IBOutlet weak var gameView: BezierPathView!
//    //gravity
//    let gravity = UIGravityBehavior()
//    //default gravity behaviour
//    
//    //reason for using lazily and closure is 1) initilise some state 2) someting that cannot be accessed during initialisation
//    lazy var collider: UICollisionBehavior = {
//        let lazilyCreatedCollider = UICollisionBehavior()
//        //inititializing a state
//        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
//        return lazilyCreatedCollider
//    }()
    
    //will not access animator until called
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
    }()
    
    let dropitBehavior = DropitBehavior()
    var attachment: UIAttachmentBehavior? {
        //setting animator if attached or not
        willSet {
            if let attachmentObj = attachment {
                animator.removeBehavior(attachmentObj)
                //removing attachment
                gameView.setPath(nil, named: PathNames.Attachment)
                
            }
            
        }
        didSet {
            if let attachmentObj = attachment{
                animator.addBehavior(attachmentObj)
                attachment?.action = { [unowned self] in 
                if let attachedView = self.attachment?.items.first as? UIView {
                    let path = UIBezierPath()
                    path.moveToPoint(self.attachment!.anchorPoint)
                    path.addLineToPoint(attachedView.center)
                        
                    self.gameView.setPath(path,
                    named: PathNames.Attachment)
                    }
                }
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropitBehavior)
//        animator.addBehavior(collider)
    }
    
    struct  PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX-barrierSize.width/2, y: gameView.bounds.midY-barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehavior.addBarrier(path, named: PathNames.MiddleBarrier)
        gameView.setPath(path, named: PathNames.MiddleBarrier)
    }
    
    //once animation reach statisis remove complete row
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    
    var dropsPerRow = 10
    
    var dropSize: CGSize{
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow) // for even spacing
        return CGSize(width: size, height: size)
        
    }
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()//func because not only tap could drop
    }
    
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView)
        
        switch sender.state {
        case .Began:
            if let viewToAttachTo = lastDroppedView {
                attachment = UIAttachmentBehavior(item: viewToAttachTo, attachedToAnchor: gesturePoint)
                lastDroppedView = nil // not allowing reattaching
            }
        case .Changed:
            attachment?.anchorPoint = gesturePoint
        case .Ended:
            attachment = nil
        default: break
        }
        
    }
    
    var lastDroppedView: UIView?
    
    
    
    func drop() {
        var frame  = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow)*dropSize.width
        
        let dropView = UIView(frame: frame)
        lastDroppedView = dropView
        dropView.backgroundColor = UIColor.random
        dropitBehavior.addDrop(dropView)
//        gameView.addSubview(dropView)
//        //adding dropView to gravity
//        gravity.addItem(dropView)
//        collider.addItem(dropView)
        
        
    }
    func removeCompletedRow(){
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        repeat {
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0 ..< dropsPerRow{
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil) {
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                        
                    } else {
                       rowIsComplete = false
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
        if rowIsComplete {
            dropsToRemove  += dropsFound
            }
        
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove{
            dropitBehavior.removeDrop(drop)
        }
    }
}

//random function
private extension CGFloat{
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
    
}
private extension UIColor {
    class var random: UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}
