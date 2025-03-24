//
//  MovieCredits.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct MovieCredits: Codable {
    var movies: [Movie]?
    enum CodingKeys: String, CodingKey {
        case movies = "cast"
    }
}
