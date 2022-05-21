//
//  UserDefaults.swift
//  MasterDetail
//
//  Created by user on 20/05/22.
//

import Foundation
import UIKit

enum StringPreference: String {
    case language
}

enum ColorPreference: String {
    case appColor
}

final class PreferenceManager {
    
    static let shared = PreferenceManager()
    
    func getPreference(_ preference: StringPreference) -> String {
        UserDefaults.standard.object(forKey: preference.rawValue) as? String ?? defaultPreference(for: preference)
    }
        
    func getPreference(_ preference: ColorPreference) -> UIColor {
        guard let colorData = UserDefaults.standard.data(forKey: preference.rawValue) else {
            return defaultPreference(for: preference)
        }
        return (try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)) ?? defaultPreference(for: preference)
    }
    
    func setPreference(_ preference: StringPreference, value: String) {
        UserDefaults.standard.set(value, forKey: preference.rawValue)
    }
    
    func setPreference(_ preference: ColorPreference, value: UIColor) {
        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: value,
                                                          requiringSecureCoding: false)
        UserDefaults.standard.set(colorData, forKey: preference.rawValue)
    }
    
    private func defaultPreference(for preference: StringPreference) -> String {
        switch preference {
        case .language:
            return "xx"
        }
    }
    
    private func defaultPreference(for preference: ColorPreference) -> UIColor {
        switch preference {
        case .appColor:
            return UIColor.systemRed
        }
    }
}
