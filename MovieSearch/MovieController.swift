//
//  MovieController.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class MovieController {
    
    static let baseURL = "httmp://api.themoviedb/org/3"
    static let apiKey = "f83783c7c1e09d03fe09770bc9c4bf57"
    
    static func fetchMovies(searchTerm: String, completion: (movies: [Movie]) -> Void) {
        
        var movieSearchURLString = MovieController.baseURL + "/search/movie"
        
        movieSearchURLString = movieSearchURLString + "?" + "api_key=" + MovieController.apiKey
        
        movieSearchURLString = movieSearchURLString + "+" + "query=" + searchTerm
        
        if let url = NSURL(string: movieSearchURLString) {
        
            NetworkController.performRequestForURL(url, httpMethod: .Get, completion: { (data, error) in
                if let data = data,
                let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                let jsonDictionary = jsonAnyObject as? [String:AnyObject],
                let resultsArray = jsonDictionary["result"] as? [[String:AnyObject]] {
                    
                    var movies: [Movie]()
                    for resultDictionary in resultsArray {
                        
                        if let movie = Movie(jsonDictionary: resultDictionary) {
                            movies.append(movie)
                        }
                    }
                    
                    completion(movies: movies)
                    
                } else {
                    completion(movies: [])
                }
            })
        } else {
            completion(movies: []))
        }
    }
}