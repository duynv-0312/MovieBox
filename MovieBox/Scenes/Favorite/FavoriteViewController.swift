//
//  FavoriteViewController.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import UIKit

final class FavoriteViewController: UIViewController, Bindable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: FavoriteViewModel!
    
    private var dataSource = [MovieFavor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataChange),
                                               name: NSNotification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.NSManagedObjectContextDidSave,
                                                  object: nil)
    }
    
    @objc private func handleDataChange() {
        fetchFavorites()
    }
    
    private func configView() {
        title = "Favorite"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteMovieCell", bundle: nil),
                           forCellReuseIdentifier: "FavoriteMovieCell")
    }
    
    private func fetchFavorites() {
        viewModel.fetchFavoriteMovies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.dataSource = movies
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as? FavoriteMovieCell else {
            return UITableViewCell()
        }
        cell.configCell(movie: dataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = dataSource[indexPath.row].id
        viewModel.toMovieDetailScreen(movieID: Int(movieID))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let movieID = dataSource[indexPath.row].id
        viewModel.deleteFavorite(movieID: Int(movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.dataSource.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }
}
