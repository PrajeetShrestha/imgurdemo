//
//  ImageListDataProvider.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

protocol ImageListDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView! { get set }
    var imageList:[IMGURImage] {get set}
    func reload()
}
