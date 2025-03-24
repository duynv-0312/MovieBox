//
//  ListMovieViewController.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import UIKit

final class ListMovieViewController: UIViewController, Bindable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: ListMovieViewModel!
    private var movies = [Movie]() 
    private var currentPage = 1
    private var isFetching = false
    
    private enum LayoutOptions {
        static let heightMovieCell: CGFloat = 290
        static let paddingCell: CGFloat = 30
        static let searchSectionIndex = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchMovies()
    }
    
    private func configView() {
        titleLabel.text = viewModel.title
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    private func fetchMovies() {
        guard !isFetching else { return }
        isFetching = true
        let url = Urls.shared.getListMovie(categories: viewModel.category, page: currentPage)
        viewModel.getMovies(urlString: url) { [weak self] result in
            guard let self else { return }
            self.isFetching = false
            switch result {
            case .success(let response):
                self.movies += response.results ?? []
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                self.showError(error: error)
            }
        }
    }
}

extension ListMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell",
                                                            for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(movie: movies[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieID =  movies[indexPath.row].id else { return }
        viewModel.toMovieDetailScreen(movieID: movieID)
    }
}

extension ListMovieViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constants.WIDTH_SCREEN - LayoutOptions.paddingCell) / 3,
                      height: LayoutOptions.heightMovieCell)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.insetForListSection
    }
}

extension ListMovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height

        if offsetY > contentHeight - frameHeight {
            fetchMovies()
        }
    }
}
