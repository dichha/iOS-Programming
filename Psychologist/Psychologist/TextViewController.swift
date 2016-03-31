//
//  TextViewController.swift
//  Psychologist
//
//  Created by raidi01 on 3/10/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    //when the oultet gets ready by system,we're going to have it's property observer be set
    
    @IBOutlet weak var textView: UITextView!{
        didSet{
            //here we don't need optional chaining since here we know that text has already been set by system
            textView.text = text
        }
        
    }
    
    //model to textView
    var text: String = ""{
        didSet{
            //optional chaining incase this is being called during preparation
            textView?.text = text
        }
    }
    override var preferredContentSize: CGSize{
        get {
            //middle of presentation
            if textView != nil && presentingViewController != nil{
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }else{
                return super.preferredContentSize
            }
        }
        set{ super.preferredContentSize = newValue}
    }
}
