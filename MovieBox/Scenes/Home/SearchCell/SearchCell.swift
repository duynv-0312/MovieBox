//
//  SearchCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import UIKit

final class SearchCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchImageView: UIImageView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var searcPlaceolderLabel: UILabel!
    
    var tappedSearch: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        titleLabel.text = "Welcome"
        bioLabel.text = "Millions of movies, TV shows and peopled to discover. Explore now."
        searchImageView.addGradientOverlay()
        searchView.layer.cornerRadius = Constants.cornerImage
        searcPlaceolderLabel.font = .systemFont(ofSize: 14)
        searcPlaceolderLabel.textColor = .lightGray
        searcPlaceolderLabel.text = "Search for a movie, person ..."
    }
    
    @IBAction func searchAction(_ sender: Any) {
        tappedSearch?()
    }
}
