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
}
