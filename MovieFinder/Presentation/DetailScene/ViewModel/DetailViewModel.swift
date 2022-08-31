//
//  DetailViewModel.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import UIKit
import RxSwift

final class DetailViewModel {
    // MARK: - Nested Types
    struct Input {
    }
    
    struct Output {
        let movieItem: Observable<MovieItem>
    }
    
    // MARK: - Properties
    private let movieItem: MovieItem
    private let disposeBag = DisposeBag()
    private weak var coordinator: DetailCoordinator!
    
    // MARK: - Initializers
    init(movieItem: MovieItem, coordinator: DetailCoordinator) {
        self.movieItem = movieItem
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func transform(_ input: Input) -> Output {
        let movieItem = configureMovieItem()
        
        let output = Output(movieItem: movieItem)
        
        return output
    }
    
    private func configureMovieItem() -> Observable<MovieItem> {
        return Observable.just(movieItem)
    }
}
