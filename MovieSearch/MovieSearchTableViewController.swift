//
//  MovieSearchTableViewController.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var searchResultMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Search Bar Delegate Method
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let searchTerm = searchBar.text ?? ""
        
        MovieController.fetchMovies(searchTerm) { (movies) in
            self.searchResultMovies = movies
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultMovies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? CustomMovieTableViewCell ?? CustomMovieTableViewCell()

        let movie = searchResultMovies[indexPath.row]
    
        cell.updateWithResults(movie)

        return cell
    }
}
