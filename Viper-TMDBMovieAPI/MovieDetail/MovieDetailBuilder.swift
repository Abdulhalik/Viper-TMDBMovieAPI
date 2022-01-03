//
//  MovieDetailBuilder.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 12.11.2021.
//

import UIKit

final class MovieDetailBuilder {
    static func make(with movie: Movie) -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        let presenter = MovieDetailPresenter(view: viewController, movie: movie)
        viewController.presenter = presenter
        return viewController
    }
}
