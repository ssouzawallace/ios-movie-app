//
//  GenresService.swift
//  MasterDetail
//
//  Created by user on 19/05/22.
//

import Foundation
import Combine
struct GenresService: Service {
    var path: String { "/genre/movie/list" }
    
    let subject = PassthroughSubject<GenresResponse, ServiceError>()
    
    func load() {
        let request = URLRequest(url: url,
                                 cachePolicy: .reloadRevalidatingCacheData,
                                 timeoutInterval: TIMEOUT)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GenresResponse.self, from: data)
                subject.send(result)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
