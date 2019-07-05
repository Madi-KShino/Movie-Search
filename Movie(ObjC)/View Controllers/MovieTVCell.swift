//
//  MovieTVCell.swift
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class MovieTVCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //UPDATE VIEWS
    func updateCellView(movieShown: MKSMovie){
        titleLabel.text = movieShown.movieTitle
        dateLabel.text = movieShown.movieDate
        summaryLabel.text = movieShown.movieSummary
        ratingLabel.text = "\(movieShown.movieRating)/10"
        movieImage.image = nil
        MKSMovieController.sharedInstance()?.fetchImage(for: movieShown, completion: { (image) in
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        })
    }
}
