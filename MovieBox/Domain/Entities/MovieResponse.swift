//
//  MovieResponse.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct MovieResponse: Codable {
    var results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
