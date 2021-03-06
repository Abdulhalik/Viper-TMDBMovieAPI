//
//  MovieListBuilder.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import UIKit

final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        let storyboard = UIStoryboard(name: "MovieList", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        let router = MovieListRouter(view: view)
        let interactor = MovieListInteractor(service: MoviesService())
        let presenter = MovieListPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        return view
    }
}
