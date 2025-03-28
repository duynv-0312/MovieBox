//
//  MovieDetailViewModel.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import Foundation

struct MovieDetailViewModel {
    let useCase: MovieDetailUseCaseType
    let navigator: MovieDetailNavigatorType
    let movieID: Int
}

extension MovieDetailViewModel {
    func getMovieDetail(completion: @escaping (Result<Movie, Error>) -> Void) {
        return useCase.getMovieDetail(id: movieID, completion: completion)
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return useCase.isMovieInFavorites(movieID)
    }
    
    func toggleFavorite(movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let movieID = movie.id else {
            completion(.failure(AppError.normalError("Invalid movie ID")))
            return
        }
        
        if isFavorite(movieID: movieID) {
            useCase.removeFavorite(movieID: movieID) { result in
                completion(result.map { _ in false })
            }
        } else {
            useCase.addFavorite(movie: movie) { result in
                completion(result.map { _ in true })
            }
        }
    }
    
    func toMovieDetailScreen(movieID: Int) {
        navigator.toMovieDetailScreen(movieID: movieID)
    }
    
    func openSafari(url: String) {
        navigator.openSafari(url: url)
    }
}
