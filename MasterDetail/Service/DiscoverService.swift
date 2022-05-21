//
//  DiscoverService.swift
//  MasterDetail
//
//  Created by user on 18/05/22.
//

import Foundation
import Combine

enum ServiceError: Error {
    case some
}

struct DiscoverService: Service {
    var path: String { "/discover/movie" }
    
    let subject = PassthroughSubject<[Movie], ServiceError>()
    
    func load () {        
        let request = URLRequest(url: url,
                                 cachePolicy: .reloadRevalidatingCacheData,
                                 timeoutInterval: TIMEOUT)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                subject.send(result.results)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
