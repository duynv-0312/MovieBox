//
//  Actor.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct Actor: Codable {
    var id: Int?
    var name: String?
    var birthday: String?
    var place: String?
    var profilePath: String?
    var biography: String?
    var knownFor: String?
    var movieCredits : MovieCredits?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthday
        case place = "place_of_birth"
        case profilePath = "profile_path"
        case biography
        case knownFor = "known_for_department"
        case movieCredits = "movie_credits"
    }
}
