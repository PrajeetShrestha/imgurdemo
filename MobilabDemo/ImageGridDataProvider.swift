//
//  ImageGridDataProvider.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class ImageGridDataProvider: NSObject, ImageGridDataProviderProtocol,CollectionViewWaterfallLayoutDelegate {
    
    var cellSizes: [CGSize] = [CGSize]()
    var controller:UIViewController!
    weak var collectionView: UICollectionView!
    var imageList:[IMGURImage] = [IMGURImage]()
    let layout = CollectionViewWaterfallLayout()
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageGridDataProvider.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    func setupCollectionViewLayout() {
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.columnCount = 2
        self.collectionView.collectionViewLayout = layout
        
    }
    
    func rotated() {
        self.layout.invalidateLayout()
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            self.layout.columnCount = 4
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
            self.layout.columnCount = 2
        }
        
    }
    
    func updateCellSizes() {
        for image in self.imageList {
            let width = (UIScreen.mainScreen().bounds.size.width - 40 ) / 2
            var height:CGFloat = 0
            let scaleFactor           = CGFloat(image.height! / image.width!)
            height = width * scaleFactor
            /*
             Max allowed height of image view cell will be 300
             */
            if height > 300 {
                height = 300
            }
            
            self.cellSizes.append(CGSize(width: width, height: height))
        }
    }
    
    
}

extension ImageGridDataProvider  {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let image       = self.imageList[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gridCell", forIndexPath: indexPath) as! GridCell
        let url = NSURL(string: image.link!)!
        cell.mainImage.sd_setImageWithURL(url)
        cell.title.text = image.title
        return cell
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == imageList.count - 1 {
            NSNotificationCenter.defaultCenter().postNotificationName(kEndOfListReached, object: nil)
        }
    }
    
    //    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    //    {
    //        // 10 being cell spacing
    //        let width:CGFloat = (self.collectionView.frame.size.width - 10) / 2
    //        let cellSize:CGSize = CGSizeMake(width, width)
    //        return cellSize
    //    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return cellSizes[indexPath.item]
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.controller.storyboard?.instantiateViewControllerWithIdentifier("DetailController") as! DetailController
        detailController.image = self.imageList[indexPath.row]
        self.controller.showDetailViewController(detailController, sender: nil)
    }
    
    func insertViewsAtIndexPaths(indexPaths:[NSIndexPath],updatedList:[IMGURImage]) {
        self.imageList = updatedList
        self.updateCellSizes()
        self.collectionView.insertItemsAtIndexPaths(indexPaths)
    }
}
