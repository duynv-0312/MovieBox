//
//  Movie.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct Movie: Codable {
    var id: Int?
    var title: String?
    var poster: String?
    var backDropPath: String?
    var releaseDate: String?
    var overview: String?
    var runtime: Int?
    var voteAverage: Double?
    var credits: Credits?
    var similar: MovieResponse?
    var videos: VideoResponse?
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster = "poster_path"
        case backDropPath = "backdrop_path"
        case releaseDate = "release_date"
        case overview
        case runtime
        case voteAverage = "vote_average"
        case credits
        case similar
        case videos
    }
    
    init() {
        id = nil
        title = nil
        poster = nil
        backDropPath = nil
        releaseDate = nil
        overview = nil
        runtime = nil
        voteAverage = nil
    }
}
