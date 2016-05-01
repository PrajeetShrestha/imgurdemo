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
protocol FilterViewControllerDelegate {
    func filterSelected(filter:IMGURFilter)
}
class FilterViewController: UIViewController {
    @IBOutlet weak var sortSegment: UISegmentedControl!
    @IBOutlet weak var windowSegment: UISegmentedControl!
    @IBOutlet weak var hotSegment: UISegmentedControl!
    @IBOutlet weak var sortContainer: UIView!
    @IBOutlet weak var windowContainer: UIView!
    @IBOutlet weak var showViral: UISwitch!
    var delegate:FilterViewControllerDelegate?
    var service = IMGURApiService()
    var page:Int = 0
    
    var filter:IMGURFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter Settings"
        self.filter.section = .User
        self.populateUIForFilter()
        // self.filter?.shouldFilterViral = showViral.on ? .True : .False
        
    }
    
    func populateUIForFilter() {
        
        switch self.filter.section! {
        case IMGURSection.User:
            self.hideWindowFilter()
            self.hotSegment.selectedSegmentIndex = IMGURSection.allValues.indexOf(IMGURSection.User)!
            break
        case .Hot:
            
            self.hideBothFilters()
            break
        case .Top:
            self.hideSortFilter()
            break
        }
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
            self.filter = IMGURFilter.hot()
            break
        case 1:
            self.hideSortFilter()
            self.filter = IMGURFilter.top()
            break
        case 2:
            self.hideWindowFilter()
            self.filter = IMGURFilter.user()
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
        if let delegate = self.delegate {
            delegate.filterSelected(self.filter!)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}

