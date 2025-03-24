//
//  ListMovieNavigator.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import Foundation
import UIKit

protocol ListMovieNavigatorType {
    func toMovieDetailScreen(movieID: Int)
}

struct ListMovieNavigator: ListMovieNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movieID: Int) {
        let useCase = MovieDetailUseCase(movieRepository: MovieRepository())
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let vm = MovieDetailViewModel(useCase: useCase, navigator: navigator, movieID: movieID)
        let vc = MovieDetailViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
