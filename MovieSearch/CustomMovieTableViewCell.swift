//
//  CustomMovieTableViewCell.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class CustomMovieTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterPathImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithResults(movie: Movie) {
        titleLabel.text = movie.title
        voteAverageLabel.text = ("\(movie.voteAverage)")
        overviewLabel.text = movie.overview
        let imagePath = MovieController.imageBaseUrl + movie.posterPath
        ImageController.imageForURL(imagePath) { (image) in
            self.posterPathImage.image = image
        }
    }
}
