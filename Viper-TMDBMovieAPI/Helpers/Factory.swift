//
//  Factory.swift
//  Viper-TMDBMovieAPI
//
//  Created by Abdulhalik Korkmaz on 11.12.2021.
//

import UIKit
import AlamofireImage

func createLabel(with text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.numberOfLines = 20
    label.textAlignment = .justified
    label.text = text
    return label
}

func createBoldLabel(with text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .preferredFont(forTextStyle: .title2)
    label.numberOfLines = 3
    label.textColor = .white
    label.text = text
    return label
}

func createPosterImageView(with url: URL) -> UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.af.setImage(withURL: url)
    return imageView
}

func createOverviewLabel(with text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.numberOfLines = 10
    return label
}
