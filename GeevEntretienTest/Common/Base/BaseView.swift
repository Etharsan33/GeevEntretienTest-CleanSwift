//
//  BaseView.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    // During initialization (Programmatic)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = xibSetup()
    }
    
    // During initialization (IB Object)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = xibSetup()
    }
    
    
}
