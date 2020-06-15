//
//  GEEV+Localizable.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

class GEEVLoc {
    
    // MARK: - Error
    enum Error: String, LocalizableProtocol {
        case ERROR_DEFAULT_TILE
    }
    
    // MARK: - Tab
    enum Tab: String, LocalizableProtocol {
        case TAB_DONATION
        case TAB_CREATION
        case TAB_MESSAGES
        case TAB_PROFILE
    }
    
    // MARK: - Donation
    enum Donation: String, LocalizableProtocol {
        case DONATION_SUBTITLE
        case DONATION_NO_RESULT
    }
}
