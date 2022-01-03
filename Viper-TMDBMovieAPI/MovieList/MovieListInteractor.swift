//
//  MovieListInteractor.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation

protocol MovieListInteractorProtocol: AnyObject {
    var delegate: MovieListInteractorDelegate? { get set }
    func load()
    func selectMovie(at index: Int)
}

protocol MovieListInteractorDelegate: AnyObject {
    func handleOutput(_ output: MovieListInteractorOutput)
}

// MARK: Enums

enum MovieListInteractorOutput: Equatable {
    case setLoading(Bool)
    case showMovieList([Movie])
    case showMovieDetail(Movie)
}

class MovieListInteractor: MovieListInteractorProtocol {
    
    var delegate: MovieListInteractorDelegate?
    
    private let service: MoviesServiceProtocol
    private var movies: [Movie] = []
    
    init(service: MoviesServiceProtocol) {
        self.service = service
    }
    
    // MARK: MovieServiceProtocols
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchMovies(from: .popular) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let value):
                self.movies = value.results
                self.delegate?.handleOutput(.showMovieList(value.results))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectMovie(at index: Int) {
        let movie = movies[index]
        delegate?.handleOutput(.showMovieDetail(movie))
    }
}
