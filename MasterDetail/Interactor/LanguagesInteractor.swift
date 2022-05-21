//
//  LanguagesInteractor.swift
//  MasterDetail
//
//  Created by user on 21/05/22.
//

import Foundation
import Combine

protocol LanguagesInteractorProtocol {
    var presenter: LanguagesPresenterProtocol? { get set }
    func load()
}

class LanguagesInteractor {
    var presenter: LanguagesPresenterProtocol?
    
    let languageService = LanguageService()
    
    init() {
        languageService.subject.subscribe(self)
    }
}

// MARK: - LanguagesInteractorProtocol
extension LanguagesInteractor: LanguagesInteractorProtocol {
    func load() {
        languageService.load()
    }
}

// MARK: - Subscriber
extension LanguagesInteractor: Subscriber {
    typealias Input = [Language]
    typealias Failure = ServiceError
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: [Language]) -> Subscribers.Demand {
        presenter?.languagesReceived(input)
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
