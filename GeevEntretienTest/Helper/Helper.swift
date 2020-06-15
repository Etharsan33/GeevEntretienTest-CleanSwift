//
//  Helper.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

struct Helper {
    
    static func osVersionIs(maj : Int) -> Bool {
        let os = ProcessInfo().operatingSystemVersion
        
        switch (os.majorVersion, os.minorVersion, os.patchVersion) {
        case (maj, _, _):
            return true
        default:
            return false
        }
    }
}
