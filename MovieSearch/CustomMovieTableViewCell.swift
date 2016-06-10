//
//  CustomMovieTableViewCell.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class CustomMovieTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
 
    // MARK: - Update Function
    
    func updateWithMovie(movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        voteAverageLabel.text = "\(movie.voteAverage)"
        
        let imagePath = MovieController.imageBaseURL + movie.posterPathImage
        ImageController.imageForURL(imagePath) { (image) in
            self.posterImageView.image = image
        }
    }
}
