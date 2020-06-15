//
//  BaseViewController.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let loadingView : LoadingView = LoadingView.instance
    
    var loadingTitle: String {
        return GEEVLoc.Error.ERROR_DEFAULT_TILE.localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingView()
    }
    
    // MARK: - Private
    fileprivate func setupLoadingView() {
        
        self.loadingView.backgroundColor = .white
        self.loadingView.frame = self.view.frame
        self.loadingView.activityIndicator.color = .donationColor
        self.loadingView.isHidden = true
        self.view.addSubview(loadingView)
        
        self.loadingView.titleLabel?.text = self.loadingTitle
        self.loadingView.titleLabel?.textColor = .black
    }
}
