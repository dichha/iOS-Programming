//
//  BezierPathView.swift
//  Dropit
//
//  Created by raidi01 on 4/20/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class BezierPathView: UIView {
    private var bezierPaths = [String:UIBezierPath]()
    func setPath(path: UIBezierPath?, named name: String){
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
    

}
