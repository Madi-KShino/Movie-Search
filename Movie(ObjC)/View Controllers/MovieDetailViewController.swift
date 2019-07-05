//
//  MovieDetailViewController.swift
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    //PROPERTIES
    var movie: MKSMovie?

    //OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        if let movie = movie {
            self.titleLabel.text = movie.movieTitle
            self.dateLabel.text = movie.movieDate
            self.summaryLabel.text = movie.movieSummary
            self.ratingLabel.text = "\(movie.movieRating)/10"
            MKSMovieController.sharedInstance()?.fetchImage(for: movie, completion: { (image) in
                DispatchQueue.main.async {
                    self.movieImage.image = image
                }
            })
        }
    }
}
