//
//  HomeViewModel.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation
import UIKit

struct HomeViewModel {
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
}

extension HomeViewModel {
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void) {
        useCase.getMovies(urlString: urlString, completion: completion)
    }
    
    func toMovieDetailScreen(movieID: Int) {
        navigator.toMovieDetailScreen(movieID: movieID)
    }
    
    func toSearchMovieScreen() {
        navigator.toSearchMovieScreen()
    }
    
    func toListMovieScreen(category: String, title: String){
        navigator.toListMovieScreen(category: category, title: title)
    }
}
