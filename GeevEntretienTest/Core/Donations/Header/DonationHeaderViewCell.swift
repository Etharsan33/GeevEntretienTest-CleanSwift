//
//  DonationHeaderViewCell.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class DonationHeaderViewCell: BaseCollectionHeaderView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let preferredHeight: CGFloat = 110
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .donationColor
        titleLabel.text = GEEVLoc.Donation.DONATION_SUBTITLE.localized
        imageView.image = #imageLiteral(resourceName: "donation_icon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
    }
}
