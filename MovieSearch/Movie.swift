//
//  Movie.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Movie {
    
    private let idKey = "id"
    private let titleKey = "original_title"
    private let overviewKey = "overview"
    private let voteAverageKey = "vote_average"
    private let posterPathKey = "poster_path"
    
    var id: Int
    var title: String
    var overview: String
    var voteAverage: Float
    var posterPath: String
    
    init(id: Int, title: String, overview: String, voteAverage: Float, posterPath: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.posterPath = posterPath
    }
    
    init?(jsonDictionary: [String:AnyObject]) {
        guard let id = jsonDictionary [idKey] as? Int,
        title = jsonDictionary [titleKey] as? String,
        overview = jsonDictionary [overviewKey] as? String,
        voteAverage = jsonDictionary [voteAverageKey] as? Float,
        posterPath = jsonDictionary [posterPathKey] as? String else {
            return nil
        }
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.posterPath = posterPath
    }
}