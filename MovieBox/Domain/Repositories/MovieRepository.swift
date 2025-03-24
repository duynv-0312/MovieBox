//
//  MovieRepository.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation
import UIKit

protocol MovieRepositoryType {
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void)
    func getMovieDetail(id: Int, completion: @escaping(Result<Movie, Error>) -> Void)
    func getSearchMovie(query: String, page: Int, completion: @escaping ((Result<MovieResponse, Error>) -> ()))
    func getActorDetail(id: Int, completion: @escaping(Result<Actor, Error>) -> Void)
}

struct MovieRepository: MovieRepositoryType {
    func getMovies(urlString: String, completion: @escaping((Result<MovieResponse, Error>) -> ())) {
        APIService.shared.get(urlString: urlString, completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: @escaping ((Result<Movie, Error>) -> Void)) {
        let urlString = Urls.shared.getMovieDetailUrl(id: id)
        APIService.shared.get(urlString: urlString, completion: completion)
    }
    
    func getSearchMovie(query: String, page: Int, completion: @escaping ((Result<MovieResponse, Error>) -> ())) {
        let urlString = Urls.shared.getSearchUrl(query: query, page: page)
        APIService.shared.get(urlString: urlString, completion: completion)
    }
    
    func getActorDetail(id: Int, completion: @escaping (Result<Actor, Error>) -> Void) {
        let urlString = Urls.shared.getActorDetailUrl(id: id)
        APIService.shared.get(urlString: urlString, completion: completion)
    }
}
