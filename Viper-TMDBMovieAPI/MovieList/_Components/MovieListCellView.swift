//
//  MovieListCell.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 12.11.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieListCellView: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    private let service = MoviesService()
    // MARK: - Life Cycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 7.0/255.0,
                                      green: 13.0/255.0,
                                      blue: 45.0/255.0,
                                      alpha: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func setMovie(movie: Movie) {
        titleLabel.text = movie.title ?? "N/A"
        if let average = movie.voteAverage {
            voteAverageLabel.text = "\(average) ⭐️"
        }
        overviewLabel.text = movie.overview
        if let url = movie.posterPath {
            guard let urll = URL(string: "https://image.tmdb.org/t/p/w500\(url)") else { return }
            posterImageView.af.setImage(withURL: urll)
            posterImageView.layer.masksToBounds = true
            posterImageView.layer.cornerRadius = 25
        }
    }
}

