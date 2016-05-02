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
    let appDelegate = UIApplication.sharedApplication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpInitialController()
        self.filter = self.setupInitialFilter()
        self.fetchImage(self.filter)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(endOfListReached), name: kEndOfListReached, object: nil)
        self.setupSegmentedControl()
    }
    
    func setupSegmentedControl() {
        let layoutSegment:UISegmentedControl = UISegmentedControl(items:["List","Grid"])
        layoutSegment.frame = CGRectMake(0, 0, 160, 30)
        layoutSegment.tintColor = kAppThemeColor
        layoutSegment.selectedSegmentIndex = 0
        layoutSegment.addTarget(self, action: #selector(selectedGridDesign), forControlEvents: .ValueChanged)
        self.navigationItem.titleView = layoutSegment
        
    }
    
    func endOfListReached() {
        self.filter.page += 1
        self.fetchAdditionalImages(self.filter)
    }
    
    func setupInitialFilter() -> IMGURFilter {
        guard let fltr = IMGURFilter.getFilterFromUserDefaults() else {
            //Returns defailt filter and save filter to User Default. this will be triggered only once.
            IMGURFilter().saveToUserDefaultsAsDictionary()
            return IMGURFilter()
        }
        return fltr
    }
    
    func fetchImage(filter:IMGURFilter) {
        self.appDelegate.networkActivityIndicatorVisible = true
        IMGURApiService().getGalleryImages(
            filter,
            success: {
                (imgList) in
                self.imageList = imgList!
                self.currentViewController?.reloadViews(self.imageList)
                self.appDelegate.networkActivityIndicatorVisible = false
            }, failure: {
                message in
                self.showAlertWithMessage(message, title: "Error")
                self.appDelegate.networkActivityIndicatorVisible = false
        })
    }
    
    func fetchAdditionalImages(filter:IMGURFilter) {
        self.appDelegate.networkActivityIndicatorVisible = true
        IMGURApiService().getGalleryImages(
            filter,
            success: {
                (imgList) in
                if imgList!.count == 0 {
                    //Reverse the page increment
                    self.filter.page = -1
                    return
                }
                let indexPaths = self.appendNewImagesAndGetIndexPathForNewImages(imgList!)
                self.currentViewController?.insertViewsAtIndexPaths(indexPaths,updatedList: self.imageList)
                self.appDelegate.networkActivityIndicatorVisible = false
            }, failure: {
                message in
                self.showAlertWithMessage(message, title: "Error")
                self.appDelegate.networkActivityIndicatorVisible = false
        })
    }
    
    func appendNewImagesAndGetIndexPathForNewImages(newImages:[IMGURImage]) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        let initialImgeListCount = self.imageList.count
        self.imageList.appendContentsOf(newImages)
        for i in  initialImgeListCount ..< self.imageList.count {
            let iPath = NSIndexPath(forRow: i, inSection: 0)
            indexPaths.append(iPath)
        }
        return indexPaths
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
        
        newViewController.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            
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
        let filterController       = segue.destinationViewController as? FilterViewController
        filterController?.delegate = self
        filterController?.filter   = IMGURFilter.getFilterFromUserDefaults()
        
    }
    //MARK: FilterViewControllerDelegate
    func filterSelected(filter:IMGURFilter) {
        
        self.fetchImage(filter)
    }
}

extension ContainerViewController {
    func showAlertWithMessage(message:String, title:String) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
        
    }
}
