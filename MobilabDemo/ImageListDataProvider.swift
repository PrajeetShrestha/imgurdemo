//
//  ImageListDataProvider.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit
import Haneke
import SDWebImage


class ImageListDataProvider: NSObject, ImageListDataProviderProtocol {
    weak var tableView: UITableView!
    var cellIdentifier: String!
    var imageList:[IMGURImage] = [IMGURImage]()
    func reload() {
        self.tableView.reloadData()
    }
}

extension ImageListDataProvider: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let image       = self.imageList[indexPath.row]
//        let scaleFactor = CGFloat(image.height! / image.width!)
//        let height = tableView.frame.size.width * CGFloat(scaleFactor)
//        return height
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let image       = self.imageList[indexPath.row]
        let cell        = tableView.dequeueReusableCellWithIdentifier("listCell")! as! ImageListCell
        let url = NSURL(string: image.link!)!
        cell.mainImage.image = nil
        cell.mainImage.sd_setImageWithURL(url)
        cell.lblDescription.text = image.description
        cell.title.text = image.title
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == imageList.count - 1 {
            NSNotificationCenter.defaultCenter().postNotificationName(kEndOfListReached, object: nil)
        }
    }
    
    func insertViewsAtIndexPaths(indexPaths:[NSIndexPath], updatedList:[IMGURImage]) {
        self.imageList = updatedList
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
}

