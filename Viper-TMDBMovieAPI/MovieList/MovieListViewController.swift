//
//  MovieListViewController.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 10.11.2021.
//

import Foundation
import UIKit

protocol MovieListViewProtocol: AnyObject {
    func handleOutput(_ output: MovieListPresenterOutput)
}

final class MovieListViewController: UIViewController, MovieListViewProtocol {

    private var movies: [Movie] = []
    let bgsColor = UIColor(red: 7.0/255.0,
                          green: 13.0/255.0,
                          blue: 45.0/255.0,
                          alpha: 1.0)
    
    var presenter: MovieListPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.load()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupTableView() {
        view.backgroundColor = bgsColor
        tableView.backgroundColor = bgsColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: Protocols
    
    func handleOutput(_ output: MovieListPresenterOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showMovieList(let movies):
            self.movies = movies
            tableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.selectMovie(at: indexPath.row)
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieListCellView else {
            return UITableViewCell()
        }
        cell.setMovie(movie: movies[indexPath.row])
        return cell
    }
}
