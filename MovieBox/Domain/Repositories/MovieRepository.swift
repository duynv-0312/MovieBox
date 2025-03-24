//
//  MovieRepository.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation
import UIKit
import CoreData

protocol MovieRepositoryType {
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void)
    func getMovieDetail(id: Int, completion: @escaping(Result<Movie, Error>) -> Void)
    func saveMovieToFavorites(movie: Movie, completion: @escaping(Result<Void, Error>) -> Void)
    func deleteMovieFromFavorites(movieID: Int, completion: @escaping(Result<Void, Error>) -> Void)
    func fetchFavoriteMovies(completion: @escaping(Result<[MovieFavor], Error>) -> Void)
    func isMovieInFavorites(movieID: Int) -> Bool
}

struct MovieRepository: MovieRepositoryType {
    func getMovies(urlString: String, completion: @escaping((Result<MovieResponse, Error>) -> ())) {
        APIService.shared.get(urlString: urlString, completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: @escaping ((Result<Movie, Error>) -> Void)) {
        let urlString = Urls.shared.getMovieDetailUrl(id: id)
        APIService.shared.get(urlString: urlString, completion: completion)
    }
    
    func saveMovieToFavorites(movie: Movie, completion: @escaping(Result<Void, Error>) -> Void) {
        let favoriteMovie = MovieFavor(context: CoreDataManager.shared.getPersistentContainer().viewContext)
        favoriteMovie.id = Int32(movie.id ?? 0)
        favoriteMovie.title = movie.title
        favoriteMovie.poster = movie.poster
        favoriteMovie.backDropPath = movie.backDropPath
        favoriteMovie.releaseDate = movie.releaseDate
        favoriteMovie.overview = movie.overview
        favoriteMovie.runtime = Int32(movie.runtime ?? 0)
        favoriteMovie.voteAverage = movie.voteAverage ?? 0.0
        CoreDataManager.shared.save(object: favoriteMovie, completion: completion)
    }
    
    func deleteMovieFromFavorites(movieID: Int, completion: @escaping(Result<Void, Error>) -> Void) {
        let context = CoreDataManager.shared.getPersistentContainer().viewContext
        let fetchRequest: NSFetchRequest<MovieFavor> = MovieFavor.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)
        if let movieToDelete = try? context.fetch(fetchRequest).first {
            CoreDataManager.shared.delete(object: movieToDelete, completion: completion)
        }
    }
    
    func fetchFavoriteMovies(completion: @escaping(Result<[MovieFavor], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<MovieFavor> = MovieFavor.fetchRequest()
        CoreDataManager.shared.fetch(request: fetchRequest, completion: completion)
    }
    
    func isMovieInFavorites(movieID: Int) -> Bool {
        let fetchRequest: NSFetchRequest<MovieFavor> = MovieFavor.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)
        return CoreDataManager.shared.isObjectExists(request: fetchRequest)
    }
}
