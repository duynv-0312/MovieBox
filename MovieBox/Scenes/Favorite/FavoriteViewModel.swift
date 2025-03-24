//
//  FavoriteViewModel.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation
import UIKit

struct FavoriteViewModel {
    let useCase: FavoriteUseCaseType
    let navigator: FavoriteNavigatorType
}

extension FavoriteViewModel {
    func fetchFavoriteMovies(completion: @escaping (Result<[MovieFavor], Error>) -> Void) {
        useCase.fetchFavoriteMovies(completion: completion)
    }
    
    func deleteFavorite(movieID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        useCase.deleteFavorite(movieID: movieID, completion: completion)
    }
    
    func toMovieDetailScreen(movieID: Int) {
        navigator.toMovieDetailScreen(movieID: movieID)
    }
}
