//
//  HomeViewController.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import UIKit

final class HomeViewController: UIViewController, Bindable {    
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var upComingMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    let dispatchGroup = DispatchGroup()
    
    private enum LayoutOptions {
        static let heightSearchCell: CGFloat = 180
        static let heightMovieCell: CGFloat = 290
        static let heightForHeader: CGFloat = 44
        static let searchSectionIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getMovies()
    }

    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchCell", bundle: nil),
                           forCellReuseIdentifier: "SearchCell")
        tableView.register(UINib(nibName: "ListMovieTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "ListMovieTableViewCell")
        tableView.register(UINib(nibName: "MovieHeader", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "MovieHeader")
    }
    
    private func getMovies() {
        dispatchGroup.enter()
        getPopularMovies()
        dispatchGroup.enter()
        getTopratedMovies()
        dispatchGroup.enter()
        getUpcomingMovies()
        dispatchGroup.enter()
        getNowplayingMovies()
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func getPopularMovies() {
        let popularURL = Urls.shared.getPopularUrl()
        viewModel.getMovies(urlString: popularURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.popularMovies = movieResponse.results ?? []
                }
            case .failure(let error):
                self.showError(error: error)
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getTopratedMovies() {
        let topRatedURL = Urls.shared.getTopRatedUrl()
        viewModel.getMovies(urlString: topRatedURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.topRatedMovies = movieResponse.results ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showError(error: error)
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getUpcomingMovies() {
        let upComingURL = Urls.shared.getUpComingUrl()
        viewModel.getMovies(urlString: upComingURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.upComingMovies = movieResponse.results ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showError(error: error)
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getNowplayingMovies() {
        let nowPlayingURL = Urls.shared.getNowPlayingUrl()
        viewModel.getMovies(urlString: nowPlayingURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.nowPlayingMovies = movieResponse.results ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showError(error: error)
            }
            self.dispatchGroup.leave()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = HomeSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .search:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
                return UITableViewCell()
            }
            cell.tappedSearch = { [weak self] in
                guard let self else { return }
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListMovieTableViewCell", for: indexPath) as? ListMovieTableViewCell else {
                return UITableViewCell()
            }

            let movies: [Movie]
            switch section {
            case .popular:
                movies = popularMovies
            case .topRated:
                movies = topRatedMovies
            case .upComing:
                movies = upComingMovies
            case .nowPlaying:
                movies = nowPlayingMovies
            default:
                movies = []
            }
            cell.configCell(movies: movies)
            cell.tappedMovie = { [weak self] movie in
                guard let self, let movieID = movie.id else { return }
                self.viewModel.toMovieDetailScreen(movieID: movieID)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == LayoutOptions.searchSectionIndex ? LayoutOptions.heightSearchCell : LayoutOptions.heightMovieCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != LayoutOptions.searchSectionIndex,
              let sectionType = HomeSectionType(rawValue: section),
              let movieHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MovieHeader") as? MovieHeader else {
            return nil
        }

        movieHeader.configView(title: sectionType.title)
        movieHeader.showMoreTapped = { [weak self] in
            guard let self else { return }
            self.viewModel.toListMovieScreen(category: sectionType.urlString, title: sectionType.title)
        }
        return movieHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : LayoutOptions.heightForHeader
    }
}
