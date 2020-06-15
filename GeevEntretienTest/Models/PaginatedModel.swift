//
//  PaginatedModel.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

struct PaginatedModel<T: Codable>: Codable {
    let page: Int?
    let pageCount: Int?
    let content: [T]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageCount = "page_count"
        case content = "ads"
    }
}
