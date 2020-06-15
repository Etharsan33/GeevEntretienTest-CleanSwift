//
//  UICollectionViewCell+Extension.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    
    // MARK: - Instance
    class func registerNibFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: self))
    }
    
    class func cellForCollection(collectionView: UICollectionView, indexPath : IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as! Self
    }
    
    /// This is a workaround method for self sizing collection view cells which stopped working for iOS 12
    func setupSelfSizingForiOS12(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
