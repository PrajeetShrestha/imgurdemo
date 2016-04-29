//
//  FetchImageProtocol.swift
//  MobilabDemo
//
//  Created by prajeet.shrestha@gmail.com on 4/28/16.
//  Copyright © 2016 Prajeet Shrestha. All rights reserved.
//

import Foundation
protocol FetchImageProtocol {
    func fetchGalleryImages(successBlock:SuccessBlock, failureBlock:FailureBlock)
}