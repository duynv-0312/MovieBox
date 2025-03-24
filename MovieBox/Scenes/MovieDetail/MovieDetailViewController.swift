//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import UIKit

final class MovieDetailViewController: UIViewController, Bindable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: MovieDetailViewModel!

    private var movie: Movie? {
         didSet {
             tableView.reloadData()
         }
     }

     override func viewDidLoad() {
         super.viewDidLoad()
         configView()
         getMovieDetail()
     }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MovieDetailInfoCell", bundle: nil),
                           forCellReuseIdentifier: "MovieDetailInfoCell")
        tableView.register(UINib(nibName: "SimilarCell", bundle: nil),
                           forCellReuseIdentifier: "SimilarCell")
    }

    private func getMovieDetail() {
        loading(true)
        viewModel.getMovieDetail { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.loading(false)
                switch result {
                case .success(let movieDetail):
                    self.movie = movieDetail
                case .failure(let error):
                    self.showError(error: error)
                }
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieDetailSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MovieDetailSectionType(rawValue: indexPath.section),
              let movie = movie else {
            return UITableViewCell()
        }

        switch section {
        case .info:
            guard let movieID = movie.id,
                  let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailInfoCell", for: indexPath) as? MovieDetailInfoCell else {
                return UITableViewCell()
            }
            let isFavorite = viewModel.isFavorite(movieID: movieID)
            cell.configCell(movie: movie, isFavorite: isFavorite)

            cell.tappedFavorite = { [weak self] movie in
                guard let self else { return }
                self.viewModel.toggleFavorite(movie: movie) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let isNowFavorite):
                            cell.updateFavoriteButtonImage(isFavorite: isNowFavorite)
                            self.showSuccess()
                        case .failure(let error):
                            self.showError(message: error.localizedDescription)
                        }
                    }
                }
            }

            cell.tappedPlay = { [weak self] movie in
                guard let self, let movieKey = movie.videos?.results?.first?.key else { return }
                let trailerUrl = Urls.shared.getTrailerUrl(key: movieKey)
                self.viewModel.openSafari(url: trailerUrl)
            }

            cell.selectionStyle = .none
            return cell

        case .similar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarCell", for: indexPath) as? SimilarCell else {
                return UITableViewCell()
            }
            cell.configCell(data: movie.similar?.results ?? [])
            cell.tappedSimilar = { [weak self] movie in
                guard let self, let id = movie.id else { return }
                self.viewModel.toMovieDetailScreen(movieID: id)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}
