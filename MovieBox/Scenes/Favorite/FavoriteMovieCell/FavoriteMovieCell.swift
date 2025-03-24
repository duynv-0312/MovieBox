//
//  FavoriteMovieCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import UIKit

final class FavoriteMovieCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        containerView.layer.cornerRadius = Constants.cornerImage
        containerView.layer.cornerCurve = .continuous
        movieImageView.layer.cornerRadius = Constants.cornerImage
        rateView.layer.cornerRadius = Constants.cornerImage / 3 // 3 is number of star
    }
    
    func configCell(movie: Movie) {
        if let path = movie.poster {
            let movieImagePath = Urls.shared.getImage(urlString: path)
            movieImageView.loadImage(fromURL: movieImagePath)
        }
        rateLabel.text = movie.voteAverage.map { "\($0)" } ?? "N/A"
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }
    
    func configCell(movie: MovieFavor) {
        if let path = movie.poster {
            let movieImagePath = Urls.shared.getImage(urlString: path)
            movieImageView.loadImage(fromURL: movieImagePath)
        }
        rateLabel.text = "\(movie.voteAverage)"
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }
}
