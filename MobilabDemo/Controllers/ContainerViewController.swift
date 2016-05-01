//
//  ContainerViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, FilterViewControllerDelegate {
    @IBOutlet weak var container: UIView!
    weak var currentViewController: AbstractDisplayController?
    var imageList:[IMGURImage] = [IMGURImage]()
    var filter:IMGURFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpInitialController()
        self.filter = self.setupInitialFilter()
        self.fetchImage(self.filter)
    }
    
    func setupInitialFilter() -> IMGURFilter {
        guard let fltr = IMGURFilter.getFilterFromUserDefaults() else {
            //Returns defailt filter
            return IMGURFilter()
        }
        return fltr
    }
    
    func fetchImage(filter:IMGURFilter) {
        IMGURApiService().getGalleryImages(
            filter,
            success: {
                (imgList) in
                self.imageList = imgList!
                self.currentViewController?.reloadViews(self.imageList)
            }, failure: {
                message in
        })
    }
    
    func setUpInitialController() {
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ListViewController") as? ListViewController
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.container)
        self.currentViewController?.reloadViews(self.imageList)
    }
    
    @IBAction func selectedGridDesign(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ListViewController") as? ListViewController
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        } else {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GridViewController") as? GridViewController
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
        self.currentViewController?.reloadViews(self.imageList)
    }
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.container)
        // TODO: Set the starting state of your constraints here
        newViewController.view.layoutIfNeeded()
        
        // TODO: Set the ending state of your constraints here
        
        UIView.animateWithDuration(0.5, animations: {
            // only need to call layoutIfNeeded here
            newViewController.view.layoutIfNeeded()
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self)
        })
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let filterController = segue.destinationViewController as? FilterViewController
        filterController?.delegate = self
        filterController?.filter   = self.filter
        
    }
    //MARK: FilterViewControllerDelegate
    func filterSelected(filter:IMGURFilter) {
        self.fetchImage(filter)
    }
}
