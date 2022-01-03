//
//  MovieDetailPresenter.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 12.11.2021.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    func load()
    func notifyViewDidLoad()
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    unowned var view: MovieDetailViewProtocol
    private let movie: Movie
    
    init(view: MovieDetailViewProtocol, movie: Movie) {
        self.view = view
        self.movie = movie
    }
    
    func notifyViewDidLoad() {
        load()
    }
    
    func load() {
        view.setupViews(movie)
    }
}
