//
//  MovieDetailViewController.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 12.11.2021.
//

import UIKit
import AlamofireImage
import CoreImage

protocol MovieDetailViewProtocol: AnyObject {
    func setupViews(_ movie: Movie)
}

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    
    var presenter: MovieDetailPresenterProtocol!
    
    var context = CIContext(options: nil)
    let margin: CGFloat = 30.0
    let spacing: CGFloat = 20.0
    var posterUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyViewDidLoad()
        view.backgroundColor = UIColor(red: 7.0/255.0,
                                       green: 13.0/255.0,
                                       blue: 45.0/255.0,
                                       alpha: 1.0)
    }
    
    func setupViews(_ movie: Movie) {
        
        let titleLabel = createBoldLabel(with: movie.title!)
        view.addSubview(titleLabel)
        
        let voteLabel = createLabel(with: "⭐️ \(movie.voteAverage!)")
        view.addSubview(voteLabel)
        
        let overviewLabel = createLabel(with: movie.overview!)
        view.addSubview(overviewLabel)
        
        if let posterPath = movie.posterPath {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
            posterUrl = url
        }
        
        let posterImageView = createPosterImageView(with: posterUrl)
        view.addSubview(posterImageView)
        
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 25
        
        posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2 * margin).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 2 * -margin).isActive = true
        
        voteLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: spacing).isActive = true
        voteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: voteLabel.bottomAnchor, constant: spacing).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
    }
}
