//
//  ImageGridDataProviderProtocol.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit
protocol ImageGridDataProviderProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    var controller:UIViewController! {get set}
    weak var collectionView: UICollectionView! { get set }
    var imageList:[IMGURImage] {get set}
    func insertViewsAtIndexPaths(indexPaths:[NSIndexPath],updatedList:[IMGURImage])
    func updateCellSizes()
    func setupCollectionViewLayout()
    
}