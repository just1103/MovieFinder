//
//  MovieItem.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import Foundation

struct MovieItem {
    let title: String
    let link: String
    let image: String
    let director: String
    let actor: String
    let userRating: String
    
    static func convert(movieItemDTO: MovieItemDTO) -> MovieItem {
        return MovieItem(
            title: movieItemDTO.title,
            link: movieItemDTO.link,
            image: movieItemDTO.image,
            director: movieItemDTO.director,
            actor: movieItemDTO.actor,
            userRating: movieItemDTO.userRating
        )
    }
}
