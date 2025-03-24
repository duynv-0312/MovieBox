//
//  HomeNavigator.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation
import UIKit

protocol HomeNavigatorType {
    func toMovieDetailScreen(movieID: Int)
    func toSearchMovieScreen()
    func toListMovieScreen(category: String, title: String)
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movieID: Int) {
        let useCase = MovieDetailUseCase(movieRepository: MovieRepository())
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let vm = MovieDetailViewModel(useCase: useCase, navigator: navigator, movieID: movieID)
        let vc = MovieDetailViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toSearchMovieScreen() {
//        let useCase = SearchUseCase()
//        let navigator = SearchNavigator(navigationController: navigationController)
//        let vm = SearchViewModel(useCase: useCase, navigator: navigator)
//        let vc = SearchViewController()
//        vc.bindViewModel(to: vm)
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func toListMovieScreen(category: String, title: String) {
        let useCase = ListMovieUseCase(movieRepository: MovieRepository())
        let navigator = ListMovieNavigator(navigationController: navigationController)
        let vm = ListMovieViewModel(useCase: useCase, navigator: navigator, category: category, title: title)
        let vc = ListMovieViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
