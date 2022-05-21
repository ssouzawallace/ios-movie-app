//
//  LanguagesPresenter.swift
//  MasterDetail
//
//  Created by user on 21/05/22.
//

import Foundation

protocol LanguagesPresenterProtocol {
    var view: LanguagesViewProtocol? { get set }
    
    func viewDidLoad()
    func languagesReceived(_ languages: [Language])
    func didSelectLanguage(_ language: String)
}

class LanguagesPresenter {
    var interactor: LanguagesInteractorProtocol = LanguagesInteractor()
    var view: LanguagesViewProtocol?
    
    init() {
        interactor.presenter = self
    }
    
}

// MARK: - LanguagesPresenterProtocol
extension LanguagesPresenter: LanguagesPresenterProtocol {
    func viewDidLoad() {
        interactor.load()
    }
    
    func languagesReceived(_ languages: [Language]) {
        let selectedLanguage = PreferenceManager.shared.getPreference(.language)
        view?.loadLanguages(languages, with: selectedLanguage)
    }
    
    func didSelectLanguage(_ language: String) {
        PreferenceManager.shared.setPreference(.language, value: language)
    }
}


