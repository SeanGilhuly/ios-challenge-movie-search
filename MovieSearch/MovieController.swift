//
//  MovieController.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class MovieController {
    
    static let baseURL = "http://api.themoviedb.org/3"
    static let apiKey = "f83783c7c1e09d03fe09770bc9c4bf57"
    
    static func fetchMovies(searchTerm: String, completion: (movies: [Movie]) -> Void) {
        
        let escapedSearchTerm = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        
        var movieSearchURLString = MovieController.baseURL + "/search/movie"
        
        movieSearchURLString = movieSearchURLString + "?" + "api_key=" + MovieController.apiKey
        
        movieSearchURLString = movieSearchURLString + "&" + "query=" + escapedSearchTerm!
        
        if let url = NSURL(string: movieSearchURLString) {
            
            NetworkController.performRequestForURL(url, httpMethod: .Get, completion: { (data, error) in
                if let data = data,
                    let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) {
                    
                    if let jsonDictionary = jsonAnyObject as? [String:AnyObject],
                        let resultsArray = jsonDictionary["results"] as? [[String:AnyObject]] {
                    
                        var movies = [Movie]()
                        for resultDictionary in resultsArray {
                        
                            if let movie = Movie(jsonDictionary: resultDictionary) {
                                movies.append(movie)
                            }
                        }
                        completion(movies: movies)
                    
                    } else {
                        completion(movies: [])
                    }
                }
            })
        } else {
            completion(movies: [])
        }
    }
}