//
//  Credits.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct Credits: Codable {
    var id: Int?
    var cast: [Cast]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}
