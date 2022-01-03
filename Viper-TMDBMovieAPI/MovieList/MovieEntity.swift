//
//  MovieEntity.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation

struct MovieResponse: Decodable {
    var results: [Movie]
}
struct Movie: Decodable, Equatable {
    let id: Int
    let title: String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?
}
