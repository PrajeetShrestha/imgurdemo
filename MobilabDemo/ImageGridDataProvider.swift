//
//  ImageGridDataProvider.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class ImageGridDataProvider: NSObject, ImageGridDataProviderProtocol {
    weak var collectionView: UICollectionView!
    var imageList:[IMGURImage] = [IMGURImage]()
}

extension ImageGridDataProvider: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let image       = self.imageList[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gridCell", forIndexPath: indexPath) as! GridCell
        let url = NSURL(string: image.link!)!
        //        cell.mainImage.image = nil
        cell.mainImage.sd_setImageWithURL(url)
        cell.title.text = image.title
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == imageList.count - 1 {
            NSNotificationCenter.defaultCenter().postNotificationName(kEndOfListReached, object: nil)
        }
    }
    
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        // 10 being cell spacing
        let width:CGFloat = (self.collectionView.frame.size.width - 10) / 2
        let cellSize:CGSize = CGSizeMake(width, width)
        return cellSize
    }
    
    func insertViewsAtIndexPaths(indexPaths:[NSIndexPath],updatedList:[IMGURImage]) {
        self.imageList = updatedList
        self.collectionView.insertItemsAtIndexPaths(indexPaths)
    }
}
