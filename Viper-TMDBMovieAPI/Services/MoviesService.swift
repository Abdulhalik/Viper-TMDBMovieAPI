//
//  MovieServices.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation
import Alamofire
import AlamofireImage

protocol MoviesServiceProtocol {
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMoviePoster(with url: String, completion: @escaping (Result<UIImage?, MovieError>) -> ())
    func fetch(with url: String, completion: @escaping (Result<UIImage?, MovieError>) -> ())
}

enum MovieListEndpoint: String, CaseIterable {
    case nowPlaying
    case upcoming
    case topRated
    case popular

    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var description: String {
        switch self {
        case .apiError: return "Failed to Fetch Data"
        case .invalidEndpoint: return "Invalid Endpoint"
        case .invalidResponse: return "Invalid Response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }

    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

class MoviesService: MoviesServiceProtocol {
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)?api_key=\(API_KEY)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(MovieError.serializationError))
                }
            case .failure(_):
                completion(.failure(MovieError.apiError))
            }
        }
    }
    
    func fetchMoviePoster(with url: String, completion: @escaping (Result<UIImage?, MovieError>) -> ()) {
        let posterUrl = "https://image.tmdb.org/t/p/w500\(url)"
        AF.request(posterUrl, method: .get).response { (response) in
            switch response.result {
            case .success(let responseData):
                guard let responseData = responseData else { return }
                let imageData = UIImage(data: responseData, scale: 1)
                completion(.success(imageData))
            case .failure(_):
                completion(.failure(MovieError.apiError))
            }
        }
    }
    
    func fetch(with url: String, completion: @escaping (Result<UIImage?, MovieError>) -> ()) {
        let posterUrl = "https://image.tmdb.org/t/p/w500\(url)"
        AF.request(posterUrl).responseImage { response in
            debugPrint(response)
            switch response.result {
            case .success(let image):
                completion(.success(image))
            case .failure(_):
                print(MovieError.apiError)
            }
        }
    }
}

