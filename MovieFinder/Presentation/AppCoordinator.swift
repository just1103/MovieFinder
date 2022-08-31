//
//  AppCoordinator.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType = .app
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        showSearchPage()
    }
    
    private func showSearchPage() {
        guard let navigationController = navigationController else { return }
//        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
//        childCoordinators.append(searchCoordinator)
//        searchCoordinator.start()
    }
}
