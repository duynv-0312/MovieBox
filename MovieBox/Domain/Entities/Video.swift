//
//  Video.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct Video: Codable {
    var key: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
    }
}
