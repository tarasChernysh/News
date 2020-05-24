//
//  NewsCategoryCoordinator.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

final class NewsCategoryCoordinator: Coordinator {
    enum State {
        case category(CategoryVC.Item)
        case country(AllowedCountry)
    }
    
    weak var viewController: UIViewController?
    private let state: State
    
    init(viewController: UIViewController? = nil, state: State) {
        self.viewController = viewController
        self.state = state
    }
    
    func start() {
        switch state {
        case .category(let category):
            let vc = R.storyboard.main.newsCategoryVC()!
            vc.state = NewsCategoryVC.State.category(category)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .country(let country):
            let vc = R.storyboard.main.newsCategoryVC()!
            vc.state = NewsCategoryVC.State.country(country)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
