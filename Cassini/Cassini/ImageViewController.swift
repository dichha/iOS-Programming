//
//  ImageViewController.swift
//  Cassini
//
//  Created by raidi01 on 4/18/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    //model
    var imageURL: NSURL? {
        didSet{
            image = nil
            //view is a toplevel view in our UIController's view 
            //fetchImage if only view.window is not nil
            if view.window != nil {
               fetchImage()
            }
            
        }
    }
    private func fetchImage()
    {
        if let url = imageURL {
            spinner.startAnimating()
            let imageData = NSData(contentsOfURL: url)//NSDatabag of bit
            if imageData != nil {
                image = UIImage(data: imageData!)
            } else {
                image = nil
            }
        }
    }
    
    

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
        {
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.00
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    //property: getter and setter
    private var image: UIImage? {
        get {return imageView.image}
        set {
            imageView.image = newValue
            imageView.sizeToFit()//expanding frame to fit
            //anytime an image is set it has to set its size as well
            scrollView?.contentSize = imageView.frame.size//? for letting size to be set even if its outlet has not been set
            spinner.stopAnimating()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding view to view hierarchy
        //view.addSubview(imageView)
        scrollView.addSubview(imageView) //builiding a view heirarchy
//        if image == nil {
//            imageURL = DemoURL.NASA.Earth
//        }
       
        
    }
    //viewl will appear later because we know it will appear later
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    

}
