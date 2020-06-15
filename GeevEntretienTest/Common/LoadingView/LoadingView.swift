//
//  LoadingView.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    enum LoadingViewState {
        case loading
        case none
        case titleOnly
    }
    
    var state : LoadingViewState = .none {
        didSet {
            DispatchQueue.main.async {
                self.isHidden = false
                
                switch self.state {
                case .loading:
                    self.titleLabel?.isHidden = true
                    self.activityIndicator?.startAnimating()
                case .none:
                    self.isHidden = true
                case .titleOnly:
                    self.titleLabel?.isHidden = false
                    self.activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - Instance
    static var instance : Self {
        return instance(owner : self)
    }
    
    private static func instance(owner : Any?) -> Self {
        let bundle = Bundle(for: self)
        return bundle.loadNibNamed(String(describing: self), owner: owner, options: nil)!.first as! Self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if self.subviews.count == 0{
            self.commonInit()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if self.subviews.count == 0{
            self.commonInit()
        }
    }
    
    func commonInit() {
        _ = self.xibSetup()
    }
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.state = .none
    }
}
