//
//  Donnation.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

struct Donation: Codable {
    let id: String
    let type: String
    let category: String?
    let title: String
    let description: String?
    let lastUpdateTimestamp: Double
    let author: Author
    let favorite: Bool
    let pictures: [String]
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case category
        case title
        case description
        case lastUpdateTimestamp = "last_update_timestamp"
        case author
        case favorite
        case pictures
        case location
    }
}
