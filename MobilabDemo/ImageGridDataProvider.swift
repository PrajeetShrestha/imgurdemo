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
    func reload() {
        self.collectionView.reloadData()
    }
}

extension ImageGridDataProvider: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
