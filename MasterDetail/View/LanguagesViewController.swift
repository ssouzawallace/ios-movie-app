//
//  LanguagesViewController.swift
//  MasterDetail
//
//  Created by user on 18/05/22.
//

import UIKit

protocol LanguagesViewProtocol {
    func loadLanguages(_ languages: [Language], with selectedLanguage: String)
}

class LanguagesViewController: UITableViewController {
    var languages: [Language] = []
    var selectedLanguage: String = ""
    
    var presenter: LanguagesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LanguagesPresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension LanguagesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let language = languages[indexPath.row]
        if language.iso_639_1 == selectedLanguage {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        var configuration = cell.defaultContentConfiguration()
        configuration.text = language.english_name
        configuration.secondaryText = language.name
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LanguagesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let language = languages[indexPath.row]
        selectedLanguage = language.iso_639_1
        tableView.reloadSections([0], with: .automatic)
        
        presenter?.didSelectLanguage(selectedLanguage)
    }
}

// MARK: - LanguagesViewProtocol
extension LanguagesViewController: LanguagesViewProtocol {
    func loadLanguages(_ languages: [Language], with selectedLanguage: String) {
        self.languages = languages
        self.selectedLanguage = selectedLanguage
        
        DispatchQueue.main.async {
            self.tableView.reloadSections([0], with: .automatic)
        }
    }
}


