//
//  MovieController.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class MovieController {
    
    private let resultsKey = "results"
    
    static let baseURL = "http://api.themoviedb.org/3"
    static let movieSearchURL = baseURL + "/search/movie"
    static let apiKey = "f83783c7c1e09d03fe09770bc9c4bf57"
    static let imageBaseURL = "http://image.tmdb.org/t/p/w500"
    
    static func getMovie(searchTerm: String, completion: (movies: [Movie]) -> Void) {
        
        guard let unwrappedURL = NSURL(string: movieSearchURL) else {
            completion(movies: [])
            return
        }
        
        let urlParameters = ["api_key":"\(apiKey)", "query":"\(searchTerm)"]
        
        NetworkController.performRequestForURL(unwrappedURL, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            guard let data = data,
                jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String:AnyObject],
                resultsArray = jsonDictionary ["results"] as? [[String:AnyObject]] else {
                    completion(movies: [])
                    return
            }
            let movies = resultsArray.flatMap {Movie(dictionary: $0)}
            completion(movies: movies)
        }
    }
}