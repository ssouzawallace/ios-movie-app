//
//  LanguageService.swift
//  MasterDetail
//
//  Created by user on 18/05/22.
//

import Foundation
import Combine

struct LanguageService: Service {
    var path: String { "/configuration/languages" }
    
    let subject = PassthroughSubject<[Language], ServiceError>()
    
    func load () {
        let request = URLRequest(url: url,
                                 cachePolicy: .reloadRevalidatingCacheData,
                                 timeoutInterval: TIMEOUT)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([Language].self, from: data)
                subject.send(result)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
