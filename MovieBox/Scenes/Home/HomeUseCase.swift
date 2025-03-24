//
//  HomeUseCase.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation

protocol HomeUseCaseType {
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void)
}

struct HomeUseCase: HomeUseCaseType {
    var movieRepository: MovieRepositoryType
    
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void) {
        movieRepository.getMovies(urlString: urlString, completion: completion)
    }
}
