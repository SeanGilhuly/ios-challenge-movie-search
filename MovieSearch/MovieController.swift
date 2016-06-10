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
    static let movieSearchUrl = MovieController.baseURL + "/search/movie"
    static let imageBaseUrl = "http://image.tmdb.org/t/p/w500"
    static let apiKey = "f83783c7c1e09d03fe09770bc9c4bf57"
    
    static func fetchMovies(searchTerm: String, completion: (movies: [Movie]) -> Void) {
        
        guard let unwrappedURL = NSURL(string: movieSearchUrl) else {
            completion(movies: [])
            return
        }
        
        let urlParameters = ["api_key":"\(apiKey)", "query":"\(searchTerm)"]
        
        NetworkController.performRequestForURL(unwrappedURL, httpMethod: .Get, urlParameters: urlParameters, completion: { (data, error) in
            guard let data = data,
                jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments),
                jsonDictionary = jsonAnyObject as? [String:AnyObject],
                resultsArray = jsonDictionary["results"] as? [[String:AnyObject]] else {
                    
                    completion(movies: [])
                    return
            }
            
            let movies = resultsArray.flatMap {Movie(jsonDictionary: $0)}
            
            completion(movies: movies)
        })
    }
}