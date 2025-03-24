//
//  ListMovieUseCase.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import Foundation

protocol ListMovieUseCaseType {
    func getMovies(urlString: String, completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

struct ListMovieUseCase: ListMovieUseCaseType {
    var movieRepository: MovieRepositoryType
    
    func getMovies(urlString: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        movieRepository.getMovies(urlString: urlString, completion: completion)
    }
}
