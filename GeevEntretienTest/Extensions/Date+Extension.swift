//
//  Date+Extension.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

extension Date {
    
    func dateDuration(toDate: Date = Date()) -> String {
        let components = Calendar.current.dateComponents([.minute, .hour, .day], from: self, to: toDate)
        
        if let day = components.day {
            return "\(day) j"
        }
        else if let hour = components.hour {
            return "\(hour) h"
        }
        else if let minute = components.minute {
            return "\(minute) min"
        }
        
        return ""
    }
}
