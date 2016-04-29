//
//  ContainerViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit
protocol ImageDisplayController {
    var datasource:[IMGURImage] {get set}
}

class ContainerViewController: UIViewController {
    var imagedisplayController:ImageDisplayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagedisplayController = ListViewController()
    }
    @IBAction func selectedGridDesign(sender: UISegmentedControl) {
        
    }
}
