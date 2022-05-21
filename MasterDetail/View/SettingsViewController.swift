//
//  SettingsViewController.swift
//  MasterDetail
//
//  Created by user on 20/05/22.
//

import Foundation
import UIKit

enum SettingsSegue: String {
    case language
    case appColor
}

final class SettingsViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsSegue = SettingsSegue(rawValue: segue.identifier ?? "") else { return }
        switch settingsSegue {
        case .language:
            let language = PreferenceManager.shared.getPreference(.language)
            let destinationViewController = segue.destination as? LanguagesViewController
            destinationViewController?.selectedLanguage = language
        case .appColor:
            let destinationViewController = segue.destination as? ColorPickerViewController
            let selectedColor = PreferenceManager.shared.getPreference(.appColor)
            destinationViewController?.selectedColor = selectedColor
            destinationViewController?.delegate = AppColorPickerInteractor()
        }
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        var configuration = cell.contentConfiguration as? UIListContentConfiguration
        if indexPath.row == 0 {
            configuration?.secondaryText = PreferenceManager.shared.getPreference(.language)
        } else if indexPath.row == 1 {
            configuration?.secondaryTextProperties.color = view.tintColor
        }
        cell.contentConfiguration = configuration
        return cell
    }
}
