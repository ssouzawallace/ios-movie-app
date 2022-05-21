//
//  GenresManager.swift
//  MasterDetail
//
//  Created by user on 21/05/22.
//

import Foundation
import Combine

class GenresManager {
    static let shared = GenresManager()
    
    private let genresService = GenresService()
    private var genres: [Genre] = []
    
    func load() {
        genresService.subject.subscribe(self)
        genresService.load()
    }
    
    func convertIds(_ genresId: [Int]) -> [String] {
        genresId.map { genreId in
            self.genres.first { genre in
                genre.id == genreId
            }?.name ?? ""
        }
    }
}

// MARK: - Subscriber
extension GenresManager: Subscriber {
    typealias Input = GenresResponse
    typealias Failure = ServiceError
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: GenresResponse) -> Subscribers.Demand {
        self.genres = input.genres
        return .none
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

