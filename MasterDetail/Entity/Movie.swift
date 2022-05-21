//
//  Movie.swift
//  MasterDetail
//
//  Created by user on 18/05/22.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
}
