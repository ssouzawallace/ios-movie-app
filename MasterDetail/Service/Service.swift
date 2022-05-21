//
//  Service.swift
//  MasterDetail
//
//  Created by user on 19/05/22.
//

import Foundation

let TIMEOUT = 30.0

protocol Service {
    var apiKey: String { get }
    var v3BaseUrl: String { get }
    
    var path: String { get }
}

extension Service {
    var apiKey: String { "68b55b92ea2373830d5d112e80508a11" }
    var v3BaseUrl: String { "https://api.themoviedb.org/3" }
    
    var url: URL {
        let language = PreferenceManager.shared.getPreference(.language)
        let string = "\(v3BaseUrl)\(path)?api_key=\(apiKey)&language=\(language)"
        guard let url = URL(string: string) else { fatalError("Error with URL: \(string)") }
        return url
    }
}
