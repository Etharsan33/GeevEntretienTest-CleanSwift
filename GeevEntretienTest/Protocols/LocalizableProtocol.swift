//
//  LocalizableProtocol.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

public protocol LocalizableProtocol {
    var rawValue: String { get }
}

extension LocalizableProtocol {
    
    /// Localized string from the main Bundle
    public var localized : String {
        
        let string = rawValue
        
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let localizableFile = "Localizable"
        let undefinedValue = appName + localizableFile + ":[Undefined String : " + string + "]"
        var val = Bundle.main.localizedString(forKey: string, value: undefinedValue, table: localizableFile)
        
        if val == undefinedValue {
            
            #if DEBUG
            assertionFailure("Missing Localizable : \(string)")
            #endif
            
            val = string.lowercased()
        }
        
        return val
    }
}
