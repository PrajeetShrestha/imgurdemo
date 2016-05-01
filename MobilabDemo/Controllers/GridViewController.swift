//
//  GridViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class GridViewController: AbstractDisplayController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataProvider:ImageGridDataProviderProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider            = ImageGridDataProvider()
        self.collectionView.dataSource    = self.dataProvider
        self.collectionView.delegate      = self.dataProvider
        self.dataProvider?.collectionView = self.collectionView
        self.dataProvider?.collectionView.reloadData()
    }
    override  func reloadViews(imageList:[IMGURImage]){
        super.reloadViews(imageList)
        dataProvider?.imageList = imageList
        self.dataProvider?.collectionView.reloadData()//.reload()
    }
    
    override     func insertViewsAtIndexPaths(indexPaths:[NSIndexPath], updatedList:[IMGURImage]) {
        self.dataProvider?.insertViewsAtIndexPaths(indexPaths,updatedList: updatedList)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

}

