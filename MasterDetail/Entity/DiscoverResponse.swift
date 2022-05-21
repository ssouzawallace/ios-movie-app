//
//  DiscoverResponse.swift
//  MasterDetail
//
//  Created by user on 18/05/22.
//

import Foundation

struct DiscoverResponse: Codable {
    let page: Int
    let results: [Movie]
}
