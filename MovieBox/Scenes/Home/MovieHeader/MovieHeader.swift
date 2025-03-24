//
//  MovieHeader.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import UIKit

final class MovieHeader: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    
    var showMoreTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configHeaderView()
    }
    
    private func configHeaderView() {
        seeMoreButton.setTitle("See more > ", for: .normal)
    }
    
    func configView(title: String) {
        headerTitleLabel.text = title
    }
    
    @IBAction func tappedSeeMoe(_ sender: Any) {
        showMoreTapped?()
    }
}
