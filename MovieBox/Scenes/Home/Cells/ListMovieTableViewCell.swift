//
//  ListMovieTableViewCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import UIKit

final class ListMovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    var tappedMovie: ((Movie) -> ())?

    private var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.register(cellType: MovieCollectionViewCell.self, forCellWithReuseIdentifier: )
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    public func configCell(movies: [Movie]) {
        self.movies = movies
    }
}

extension ListMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedMovie?(movies[indexPath.row])
    }
}

extension ListMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 290)
    }
}
