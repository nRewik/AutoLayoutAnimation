//
//  SecondViewController.swift
//  AutoLayoutAnimation
//
//  Created by Nutchaphon Rewik on 7/18/15.
//  Copyright (c) 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    var selected = false
    
    @IBOutlet var greenGreyHorizontalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var greenViewWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func redButtonPressed() {
        
        selected = !selected
        
        if selected{
            greenViewWidthConstraint.constant = 0
            greenGreyHorizontalSpaceConstraint.active = false
        }else{
            greenViewWidthConstraint.constant = 75
            greenGreyHorizontalSpaceConstraint.active = true
        }
        
        UIView.animateWithDuration(0.3){
            self.view.layoutIfNeeded()
        }
        
        
    }
    
}
