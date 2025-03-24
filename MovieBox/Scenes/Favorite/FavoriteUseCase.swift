//
//  FavoriteUseCase.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation

protocol FavoriteUseCaseType {
    func fetchFavoriteMovies(completion: @escaping (Result<[MovieFavor], Error>) -> Void)
    func deleteFavorite(movieID: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

struct FavoriteUseCase: FavoriteUseCaseType {
    let movieRepository: MovieRepositoryType

    func fetchFavoriteMovies(completion: @escaping (Result<[MovieFavor], Error>) -> Void) {
        movieRepository.fetchFavoriteMovies(completion: completion)
    }

    func deleteFavorite(movieID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        movieRepository.deleteMovieFromFavorites(movieID: movieID, completion: completion)
    }
}
