//
//  MovieDetailUseCase.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import Foundation

protocol MovieDetailUseCaseType {
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func isMovieInFavorites(_ movieID: Int) -> Bool
    func addFavorite(movie: Movie, completion: @escaping (Result<Void, Error>) -> Void)
    func removeFavorite(movieID: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieRepository: MovieRepositoryType

    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        movieRepository.getMovieDetail(id: id, completion: completion)
    }

    func isMovieInFavorites(_ movieID: Int) -> Bool {
        movieRepository.isMovieInFavorites(movieID: movieID)
    }

    func addFavorite(movie: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        movieRepository.saveMovieToFavorites(movie: movie, completion: completion)
    }

    func removeFavorite(movieID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        movieRepository.deleteMovieFromFavorites(movieID: movieID, completion: completion)
    }
}
