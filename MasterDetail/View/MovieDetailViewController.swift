//
//  ViewController.swift
//  MasterDetail
//
//  Created by user on 17/05/22.
//

import UIKit

protocol MovieDetailViewProtocol {
    var presenter: MoviesPresenter? { get set }
}

class MovieDetailViewController: UIViewController {    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var movie: Movie?
    
    var presenter: MoviesPresenter?
    let imagesService = ImagesDownloader()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = movie?.title
        titleLabel.text = movie?.title
        genresLabel.text = GenresManager.shared.convertIds(movie?.genre_ids ?? []).joined(separator: " • ")
        overViewLabel.text = movie?.overview
        
        self.backdropImageView.image = nil
        imagesService.download(movie?.poster_path ?? "") { image in
            DispatchQueue.main.async {
                self.backdropImageView.image = image
            }
        }
    }
}

// MARK: - MovieDetailViewProtocol
extension MovieDetailViewController: MovieDetailViewProtocol {
    
}

