//
//  ListViewController.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/29/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ImageDisplayController {
    private var _datasource:[IMGURImage]!
    var datasource:[IMGURImage] {
        get {
            return self._datasource
        } set {
            self._datasource = newValue
        }
    }
}
