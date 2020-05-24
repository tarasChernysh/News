//
//  AppCoordinator.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    enum State {
        case category
        case source
        case country
        case search
    }
    
    weak var viewController: UIViewController?
    private let state: State
    
    init(viewController: UIViewController? = nil, state: State) {
        self.viewController = viewController
        self.state = state
    }
    
    func start() {
        switch state {
        case .category:
            let vc = R.storyboard.main.categoryVC()!
            vc.state = .category
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .source:
            let vc = R.storyboard.main.sourceVC()!
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .country:
            let vc = R.storyboard.main.categoryVC()!
            vc.state = .country
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .search:
            let vc = R.storyboard.main.searchVC()!
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
