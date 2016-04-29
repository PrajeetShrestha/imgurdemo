//
//  ViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/28/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

/*
 Each response is wrapped in a data tag.
 This means if you have a response, it will always be within the data field. We also include a status code and success flag in the response
 */

class FilterViewController: UIViewController {
    @IBOutlet weak var sortSegment: UISegmentedControl!
    @IBOutlet weak var windowSegment: UISegmentedControl!
    @IBOutlet weak var hotSegment: UISegmentedControl!
    @IBOutlet weak var sortContainer: UIView!
    @IBOutlet weak var windowContainer: UIView!
    @IBOutlet weak var showViral: UISwitch!
    
    var filter:IMGURFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter Settings"
        self.configureDefaultFilter()
    }
    
    func configureDefaultFilter() {
        self.configureFilterForHotSection()
        self.hideBothFilters()
        self.filter?.shouldFilterViral = showViral.on ? .True : .False
        
    }
    
    func configureFilterForHotSection() {
        self.filter = IMGURFilter()
        self.filter?.section = .Hot
    }
    
    func configureFilterForTopSection() {
        self.filter                    = IMGURFilter()
        self.filter?.section           = .Top
        self.filter?.window            = .Day
    }
    
    func configureFilterForUserSection() {
        self.filter                    = IMGURFilter()
        self.filter?.section           = .User
        self.filter?.sort              = .Viral
    }
    
    func hideWindowFilter() {
        self.sortContainer.hidden   = false
        self.windowContainer.hidden = true
    }
    
    func hideSortFilter() {
        self.sortContainer.hidden   = true
        self.windowContainer.hidden = false
    }
    
    func hideBothFilters() {
        self.sortContainer.hidden   = true
        self.windowContainer.hidden = true
    }
}
//MARK: Actions
extension FilterViewController {
    
    @IBAction func sectionSelected(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.hideBothFilters()
            self.configureFilterForHotSection()
            break
        case 1:
            self.hideSortFilter()
            self.configureFilterForTopSection()
            break
        case 2:
            self.hideWindowFilter()
            self.configureFilterForUserSection()
            break
        default:
            self.hideBothFilters()
            break
        }
    }
    
    @IBAction func sortSegmentSelected(sender: UISegmentedControl) {
        self.filter?.sort = IMGURSort.allValues[sender.selectedSegmentIndex]
    }
    
    @IBAction func windowSegmentSelected(sender: UISegmentedControl) {
        self.filter?.window = IMGURWindow.allValues[sender.selectedSegmentIndex]
    }
    
    @IBAction func shouldShowViral(sender: UISwitch) {
        self.filter?.shouldFilterViral = sender.on ? .True : .False
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        let path = IMGURApiService.createPath(self.filter!, page: 0)
        
        
        IMGURApiService.getGalleryAt(
            path,
            success: {
                (response) in
                
            },
            failure: {
                message in
        })
        
    }
}

