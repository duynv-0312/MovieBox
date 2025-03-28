//
//  FavoriteNavigator.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation
import UIKit

protocol FavoriteNavigatorType {
    func toMovieDetailScreen(movieID: Int)
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController

    func toMovieDetailScreen(movieID: Int) {
        let useCase = MovieDetailUseCase(movieRepository: MovieRepository())
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(useCase: useCase, navigator: navigator, movieID: movieID)
        let vc = MovieDetailViewController()
        vc.bindViewModel(to: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
