//
//  ResourcesManager.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import Kingfisher

struct ResourcesManager {
    
    static let shared = ResourcesManager()
    
    fileprivate let smallImageLoader : ImageDownloader
    fileprivate let smallCache : ImageCache
    
    init() {
        self.smallImageLoader = ImageDownloader(name: "smallImageLoader")
        self.smallImageLoader.downloadTimeout = 3.0
        self.smallCache = ImageCache(name: "smallCache")
        self.smallCache.diskStorage.config.sizeLimit = UInt(100 * 1024 * 1024)
        self.smallCache.diskStorage.config.expiration = .days(1)
    }
    
    func loadImageUrl(_ imageID: String?, imageView: UIImageView?, dimension: Int = 300) {
        let pictureDimension = "squares/\(dimension)"
        
        guard let imageID = imageID,
            let url = URL(string: "\(Constants.Network.basePictureURL)/\(imageID)/\(pictureDimension)") else {
            imageView?.image = #imageLiteral(resourceName: "placeholder")
            return
        }
        
        imageView?.kf.indicatorType = .activity
        
        let options : KingfisherOptionsInfo = [.downloader(self.smallImageLoader),
                                               .targetCache(self.smallCache),
                                               .transition(.fade(0.2)),
                                               .onFailureImage(#imageLiteral(resourceName: "placeholder"))
        ]
        
        imageView?.kf.setImage(with: url, placeholder: nil, options: options, progressBlock: nil)
    }
    
}
