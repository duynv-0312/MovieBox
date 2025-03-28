//
//  Urls.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation

struct Urls {
    static let shared = Urls()
    let baseUrl = "https://api.themoviedb.org/3"
    let key = Bundle.main.infoDictionary?["API_KEY"] as! String
    enum Path: String {
        case topRated = "/movie/top_rated"
        case popular = "/movie/popular"
        case upComing = "/movie/upcoming"
        case nowPlaying = "/movie/now_playing"
    }
    
    func getTopRatedUrl() -> String {
        let urlString = baseUrl + Path.upComing.rawValue + "?api_key=95d6a6ef93001af6e75d828b5716d601"
        return urlString
    }
    
    func getPopularUrl() -> String {
        let urlString = baseUrl + Path.popular.rawValue + "?api_key=\(key)"
        return urlString
    }
    
    func getUpComingUrl() -> String {
        let urlString = baseUrl + Path.upComing.rawValue + "?api_key=\(key)"
        return urlString
    }
    
    func getNowPlayingUrl() -> String {
        let urlString = baseUrl + Path.nowPlaying.rawValue + "?api_key=\(key)"
        return urlString
    }
    
    func getListMovie(categories: String, page: Int) -> String {
        let urlString = baseUrl + "/movie/\(categories)" + "?api_key=\(key)&page=\(page)"
        return urlString
    }
    
    func getImage(urlString: String) -> String {
        let urlString = "https://image.tmdb.org/t/p/w500/\(urlString)?api_key=\(key)"
        return urlString
    }

    func getMovieDetailUrl(id: Int) -> String {
        return baseUrl + "/movie/\(id)?api_key=\(key)&append_to_response=credits,similar,videos"
    }
    
    func getTrailerUrl(key: String) -> String {
        return "https://www.youtube.com/watch?v=\(key)"
    }
}
