//
//  Decoders.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation

public enum Decoders {
    public static let plainDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
