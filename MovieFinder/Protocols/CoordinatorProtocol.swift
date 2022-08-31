//
//  CoordinatorProtocol.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import UIKit

enum CoordinatorType {
    case app
    case lookup, detail
    case screenshot
}

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
}
