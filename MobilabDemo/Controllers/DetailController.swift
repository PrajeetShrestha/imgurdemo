//
//  DetailController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 5/1/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    var image:IMGURImage!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblUpVotes: UILabel!
    @IBOutlet weak var lblDownVotes: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateUIWithImageData()
    }
    
    func populateUIWithImageData() {
        let scaleFactor           = CGFloat(image.height! / image.width!)
        heightConstraint.constant = UIScreen.mainScreen().bounds.size.width * CGFloat(scaleFactor)
        self.lblTitle.text        = self.image.title
        self.lblDescription.text  = self.image.description
        self.lblUpVotes.text      = "\(self.image.ups!)"
        self.lblDownVotes.text    = "\(self.image.downs!)"
        self.lblScore.text        = "\(self.image.score!)"
        let url = NSURL(string: image.link!)!
        self.mainImage.sd_setImageWithURL(url)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        let scaleFactor           = CGFloat(image.height! / image.width!)
        heightConstraint.constant = size.width * CGFloat(scaleFactor)
        print(heightConstraint.constant)
        self.view.layoutIfNeeded()
    }
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
