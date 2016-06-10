//
//  Movie.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Movie {
    
    private let titleKey = "title"
    private let overviewKey = "overview"
    private let voteAverageKey = "vote_average"
    private let posterPathImageKey = "poster_path"
    
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPathImage: String
    
    init?(dictionary: [String:AnyObject]) {
        guard let title = dictionary [titleKey] as? String,
            overview = dictionary [overviewKey] as? String,
            voteAverage = dictionary [voteAverageKey] as? Double,
            posterPathImage = dictionary [posterPathImageKey] as? String else {
                return nil
        }
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.posterPathImage = posterPathImage
    }
}