//
//  TableViewController.swift
//  MasterDetail
//
//  Created by user on 17/05/22.
//

import UIKit

protocol MoviesListViewProtocol {
    func loadMovies(_ movies: [Movie])
}

class TableViewController: UITableViewController {    
    var presenter: MoviesPresenterProtocol? = MoviesPresenter()
    var movies: [Movie] = []
        
    let imagesDownloader = ImagesDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.listView = self
        
        presenter?.viewDidLoad()
    }
    
    func presentError(_ description: String) {
        let ac = UIAlertController(title: "Error",
                                   message: description,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = movies[indexPath.row]
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = movie.title
        configuration.secondaryText = movie.overview
        if let image = imagesDownloader.image(for: movie.poster_path, fileSize: .thumbnail) {
            configuration.image = image
        } else {
            imagesDownloader.download(movie.poster_path, fileSize: .thumbnail) { image in
                DispatchQueue.main.async {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        presenter?.didSelectMovie(movie)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MoviesListViewProtocol
extension TableViewController: MoviesListViewProtocol {
    func loadMovies(_ movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadSections([0], with: .automatic)
        }
    }
}
    
