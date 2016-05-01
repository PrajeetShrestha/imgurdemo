//
//  ListViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class ListViewController: AbstractDisplayController {
    @IBOutlet weak var tableView: UITableView!
    var dataProvider:ImageListDataProviderProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider            = ImageListDataProvider()
        self.tableView.dataSource    = self.dataProvider
        self.tableView.delegate      = self.dataProvider
        self.dataProvider?.tableView = self.tableView
        self.dataProvider?.reload()
    }
    override  func reloadViews(imageList:[IMGURImage]){
        super.reloadViews(imageList)
        dataProvider?.imageList = imageList
        self.dataProvider?.reload()
    }
}
