//
//  MovieDetailNavigator.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import Foundation
import UIKit
import SafariServices

protocol MovieDetailNavigatorType {
    func toMovieDetailScreen(movieID: Int)
    func openSafari(url: String)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let navigationController: UINavigationController

    func toMovieDetailScreen(movieID: Int) {
        let useCase = MovieDetailUseCase(movieRepository: MovieRepository())
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let vm = MovieDetailViewModel(useCase: useCase, navigator: navigator, movieID: movieID)
        let vc = MovieDetailViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    func openSafari(url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        navigationController.present(safariVC, animated: true)
    }
}
