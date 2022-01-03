//
//  MovieListPresenter.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation

protocol MovieListPresenterProtocol: AnyObject {
    func load()
    func selectMovie(at index: Int)
}

enum MovieListPresenterOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovieList([Movie])
}

final class MovieListPresenter: MovieListPresenterProtocol {
    
    private unowned let view: MovieListViewProtocol
    private let interactor: MovieListInteractorProtocol
    private let router: MovieListRouterProtocol
    
    init(view: MovieListViewProtocol,
         interactor: MovieListInteractorProtocol,
         router: MovieListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
    }
    
    func load() {
        view.handleOutput(.updateTitle("Movies"))
        interactor.load()
    }
    
    func selectMovie(at index: Int) {
        interactor.selectMovie(at: index)
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    
    func handleOutput(_ output: MovieListInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showMovieList(let movies):
            view.handleOutput(.showMovieList(movies))
        case .showMovieDetail(let movie):
            router.navigate(to: .detail(movie))
        }
    }
}
