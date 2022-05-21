//
//  MoviesPresenter.swift
//  MasterDetail
//
//  Created by user on 21/05/22.
//

import Foundation

protocol MoviesPresenterDelegate {
    func show(movie: Movie)
}

protocol MoviesPresenterProtocol {
    var listView: MoviesListViewProtocol? { get set }
    var detailView: MovieDetailViewProtocol? { get set }
    
    var interactor: MoviesInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didReceiveMovies(_ movies: [Movie])
    func didSelectMovie(_ movie: Movie)
}

class MoviesPresenter {
    var listView: MoviesListViewProtocol?
    var detailView: MovieDetailViewProtocol?
    
    var interactor: MoviesInteractorProtocol? = MoviesInteractor()
    
    var delegate: MoviesPresenterDelegate?
    
    init() {
        interactor?.presenter = self
    }
}

// MARK: - MoviesPresenterProtocol
extension MoviesPresenter: MoviesPresenterProtocol {
    func viewDidLoad() {
        interactor?.load()
    }
    
    func didReceiveMovies(_ movies: [Movie]) {
        listView?.loadMovies(movies)
    }
    
    func didSelectMovie(_ movie: Movie) {
        delegate?.show(movie: movie)
    }
}
