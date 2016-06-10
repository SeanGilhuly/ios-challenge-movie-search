//
//  MovieSearchTableViewController.swift
//  MovieSearch
//
//  Created by Sean Gilhuly on 6/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {

    var searchResults: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Search Bar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        searchBar.autocapitalizationType = .Words
        searchBar.resignFirstResponder()
        
        MovieController.getMovie(searchTerm) { (movies) in
            self.searchResults = movies
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        searchBar.text = ""
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? CustomMovieTableViewCell ?? CustomMovieTableViewCell()

        let movie = searchResults[indexPath.row]
        cell.updateWithMovie(movie)
        
        return cell
    }
}