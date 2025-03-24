//
//  MovieCollectionViewCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        posterImageView.layer.cornerRadius = Constants.cornerImage
        releaseDateLabel.textColor = .secondaryLabel
    }
    
    func configCell(movie: Movie) {
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        let posterImageString = Urls.shared.getImage(urlString: movie.poster ?? "")
        posterImageView.loadImage(fromURL: posterImageString)
    }
}
