//
//  ImageListDataProvider.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit
protocol DataProviderDelegate {
    func endOfListReached()
}
protocol ImageListDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
    var controller:UIViewController! {get set}
    weak var tableView: UITableView! { get set }
    var imageList:[IMGURImage] {get set}
    func reload()
    func insertViewsAtIndexPaths(indexPaths:[NSIndexPath],updatedList:[IMGURImage])
}
