//
//  SearchResultDTO.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import Foundation

struct SearchResultDTO: Decodable {
    let items: [MovieItemDTO]
}
