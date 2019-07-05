//
//  MovieListTableViewController.swift
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //SOURCE OF TRUTH
    var movies: [MKSMovie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //OUTLETS
    @IBOutlet weak var searchBar: UISearchBar!
    
    //LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        MKSMovieController.sharedInstance()?.fetchMovie(fromSearch: "Star Wars", completion: { (movie) in
            guard let movie = movie else { return }
            self.movies = movie
        })
    }
    
    //TABLE VIEW DATA
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTVCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.updateCellView(movieShown: movie)
        
        return cell
    }
    
    //SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailViewController" {
            guard let index = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? MovieDetailViewController
                else { return }
            let movie = movies[index.row]
            destination.movie = movie
        }
    }
}

//SEARCH BAR FUNCTIONALITY
extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view .endEditing(true)
        guard let searchText = searchBar.text, searchText != "" else { return }
        MKSMovieController.sharedInstance()?.fetchMovie(fromSearch: searchText, completion: { (moviesFromCompletion) in
            if let movies = moviesFromCompletion {
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
}

