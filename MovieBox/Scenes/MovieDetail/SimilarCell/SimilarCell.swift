//
//  SimilarCell.swift
//  MovieBox
//
//  Created by Duy Nguyen on 24/3/25.
//

import UIKit

final class SimilarCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var recommendTitle: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageView: UIPageControl!
    
    var tappedSimilar: ((Movie) -> Void)?
    private var dataSource = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private enum LayoutOptions {
        static let heightSimilarCell: CGFloat = 220
        static let widthSimilarCell: CGFloat = 250
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        pageView.isUserInteractionEnabled = false
        pageView.currentPageIndicatorTintColor = .white
        pageView.pageIndicatorTintColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TrailerCell", bundle: nil),
                                         forCellWithReuseIdentifier: "TrailerCell")
    }
    
    func configCell(data: [Movie]) {
        self.dataSource = data
        self.pageView.numberOfPages = data.count
    }
}

extension SimilarCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrailerCell",
                                                            for: indexPath) as? TrailerCell else {
            return UICollectionViewCell()
        }
        cell.configSimilarCell(movie: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedSimilar?(dataSource[indexPath.row])
    }
}

extension SimilarCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: LayoutOptions.widthSimilarCell, height: LayoutOptions.heightSimilarCell)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.insetForSection
    }
}

extension SimilarCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageView.currentPage = indexPath.row
    }
}
