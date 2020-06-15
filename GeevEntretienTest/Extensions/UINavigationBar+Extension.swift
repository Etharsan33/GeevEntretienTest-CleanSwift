//
//  UINavigationBar+Extension.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    func transparent(_ isTransparent: Bool = true) {
        self.setBackgroundImage(isTransparent ? UIImage() : nil, for: .default)
        self.shadowImage = (isTransparent) ? UIImage() : nil
        self.isTranslucent = true
    }
    
}
