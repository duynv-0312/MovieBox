//
//  ListMovieViewModel.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import Foundation

struct ListMovieViewModel {
    let useCase: ListMovieUseCaseType
    let navigator: ListMovieNavigatorType
    let category: String
    let title: String
}

extension ListMovieViewModel {
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void) {
        useCase.getMovies(urlString: urlString, completion: completion)
    }

    func toMovieDetailScreen(movieID: Int) {
        navigator.toMovieDetailScreen(movieID: movieID)
    }
}
