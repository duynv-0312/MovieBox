//
//  TrailerCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import UIKit

final class TrailerCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backDropImageView: UIImageView!
    @IBOutlet private weak var playImageView: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.layer.cornerRadius = Constants.cornerImage
        if #available(iOS 13.0, *) {
            containerView.layer.cornerCurve = .continuous
            backDropImageView.layer.cornerCurve = .continuous
        }
        backDropImageView.layer.cornerRadius = Constants.cornerImage
    }
    
    func configSimilarCell(movie: Movie) {
        playImageView.isHidden = true
        if let path = movie.backDropPath {
            let backDropPath = Urls.shared.getImage(urlString: path)
            backDropImageView.loadImage(fromURL: backDropPath)
        }
        movieName.text = movie.title
    }
}
