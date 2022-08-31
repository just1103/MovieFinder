//
//  DetailCoordinator.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import UIKit

protocol DetailCoordinatorDelegete: AnyObject {
    func removeFromChildCoordinators(coordinator: CoordinatorProtocol)
}

final class DetailCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    weak var delegate: DetailCoordinatorDelegete!
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType = .detail
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start(with movieItem: MovieItem) {
        showDetailPage(with: movieItem)
    }
    
    func finish() {
        delegate.removeFromChildCoordinators(coordinator: self)
    }
    
    func popCurrentPage() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showDetailPage(with movieItem: MovieItem) {
        guard let navigationController = navigationController else { return }
        let detailViewModel = DetailViewModel(movieItem: movieItem, coordinator: self)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
}