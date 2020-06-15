//
//  Author.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

struct Author: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let picture: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case picture
    }
}

extension Author {
    
    var fullname: String {
        return "\(firstName) \(lastName)"
    }
}
