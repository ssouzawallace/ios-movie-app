//
//  MoviesInteractor.swift
//  MasterDetail
//
//  Created by user on 21/05/22.
//

import Foundation
import Combine

protocol MoviesInteractorProtocol {
    var presenter: MoviesPresenterProtocol? { get set }
    func load()
}

class MoviesInteractor {
    var presenter: MoviesPresenterProtocol?
    let discoverService = DiscoverService()
    
    init() {
        discoverService.subject.subscribe(self)
    }
}

// MARK: - MoviesInteractorProtocol
extension MoviesInteractor: MoviesInteractorProtocol {
    func load() {
        discoverService.load()
    }
}

// MARK: - Subscriber
extension MoviesInteractor: Subscriber {
    typealias Input = [Movie]
    typealias Failure = ServiceError
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: [Movie]) -> Subscribers.Demand {
        presenter?.didReceiveMovies(input)
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<ServiceError>) {
        switch completion {
        case .failure(_):
            // TODO: deal with error
            break
        case .finished:
            break
        }
    }
        
}
