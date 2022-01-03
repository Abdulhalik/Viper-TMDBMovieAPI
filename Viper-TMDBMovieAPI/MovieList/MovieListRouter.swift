//
//  MovieListRouter.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation
import UIKit

enum MovieListRoute: Equatable {
    case detail(Movie)
}

protocol MovieListRouterProtocol: AnyObject {
    func navigate(to route: MovieListRoute)
}

final class MovieListRouter: MovieListRouterProtocol {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: MovieListRoute) {
        switch route {
        case .detail(let movie):
            let detailView = MovieDetailBuilder.make(with: movie)
            view.show(detailView, sender: nil)
        }
    }
}
