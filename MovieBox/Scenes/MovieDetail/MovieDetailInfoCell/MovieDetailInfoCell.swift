//
//  MovieDetailInfoCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import UIKit

class MovieDetailInfoCell: UITableViewCell {
    @IBOutlet private weak var backDropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var overViewTitle: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var tappedFavorite: ((Movie) -> Void)?
    var tappedPlay: ((Movie) -> Void)?
    private var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        backDropImageView.addGradientOverlay()
        posterImageView.layer.cornerRadius = Constants.cornerImage
        posterImageView.layer.cornerCurve = .continuous
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.borderWidth = 3
        favoriteButton.tintColor = .systemPink
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        playButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        playButton.tintColor = .white
        movieNameLabel.textColor = .white
        descriptionLabel.textColor = .secondaryLabel
    }
    
    
    func configCell(movie: Movie, isFavorite: Bool) {
        descriptionLabel.text = movie.overview
        movieNameLabel.text = movie.title
        timeLabel.text = "Runtime: \(movie.runtime ?? 0) min"
        self.movie = movie
        let backDropUrl = Urls.shared.getImage(urlString: movie.backDropPath ?? "")
        backDropImageView.loadImage(fromURL: backDropUrl)
        let posterUrl = Urls.shared.getImage(urlString: movie.poster ?? "")
        posterImageView.loadImage(fromURL: posterUrl)
        updateFavoriteButtonImage(isFavorite: isFavorite)
    }
    
    func updateFavoriteButtonImage(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func tappedFavoriteButton(_ sender: Any) {
        guard let movie = movie else { return }
        tappedFavorite?(movie)
    }
    
    @IBAction func tappedPlayButton(_ sender: Any) {
        guard let movie = movie else { return }
        tappedPlay?(movie)
    }
}
