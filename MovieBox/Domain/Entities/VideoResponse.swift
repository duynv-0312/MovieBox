//
//  VideoResponse.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct VideoResponse: Codable {
    var results: [Video]?
    enum CodingKeys: String, CodingKey {
        case results
    }
}
