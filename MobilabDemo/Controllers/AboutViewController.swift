//
//  AboutViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 5/1/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var lblAbout: UILabel!
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func shareInfo(sender: AnyObject) {
        self.shareWithActivityController()
    }
    func shareWithActivityController() {
        var sharingItems = [AnyObject]()
        sharingItems.append(self.lblAbout.text!)
        let activityVC = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
}
