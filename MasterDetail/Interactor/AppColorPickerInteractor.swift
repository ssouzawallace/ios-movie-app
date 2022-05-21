//
//  AppColorPickerInteractor.swift
//  MasterDetail
//
//  Created by user on 21/05/22.
//

import Foundation
import UIKit

class AppColorPickerInteractor {
    func load() {
        let color = PreferenceManager.shared.getPreference(.appColor)
        update(color)
    }
    
    private func update(_ color: UIColor) {
        UIApplication.shared.connectedScenes.forEach { scene in
            if let scene = scene as? UIWindowScene {
                scene.keyWindow?.tintColor = color
            }
        }
    }
}

extension AppColorPickerInteractor: ColorPickerDelegate {
    func colorChaged(to color: UIColor) {
        PreferenceManager.shared.setPreference(.appColor, value: color)
        update(color)
    }
}
