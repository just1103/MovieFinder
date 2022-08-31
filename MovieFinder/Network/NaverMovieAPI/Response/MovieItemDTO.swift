//
//  MovieItemDTO.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import Foundation

struct MovieItemDTO: Decodable {
    let title: String
    let link: String
    let image: String
    let director: String
    let actor: String
    let userRating: String
}
