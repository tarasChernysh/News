//
//  CategoryVC.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

final class CategoryVC: BaseVC {
    enum State {
        case category
        case country
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var state: State = .category
    private let items: [Item] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
    private let countries = AllowedCountry.allCases
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeValueFromUserDefaultsForCorrectWorkInNewCategoryVC()
    }
    
    // MARK: - Setup
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.filterTVC)
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        switch state {
        case .category:
            title = "Choose category"
        case .country:
            title = "Choose country"
        }
    }
    
    private func removeValueFromUserDefaultsForCorrectWorkInNewCategoryVC() {
        UserDefaults.standard.removeCategoryNewsTotalResult()
        UserDefaults.standard.removeAvailableCountCategoryNews()
    }
}

// MARK: - UITableViewDataSource

extension CategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .category:
            return items.count
        case .country:
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.filterTVC, for: indexPath)!
        switch state {
        case .category:
            cell.configure(with: items[indexPath.row])
        case .country:
            cell.configure(with: countries[indexPath.row])
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .category:
            let coordinator = NewsCategoryCoordinator(viewController: self, state: .category(items[indexPath.row]))
            coordinator.start()
        case .country:
            let coordinator = NewsCategoryCoordinator(viewController: self, state: .country(countries[indexPath.row]))
            coordinator.start()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CategoryVC {
    enum Item: String {
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
        
        var title: String {
            switch self {
            case .business:
                return "Business"
            case .entertainment:
                return "Entertainment"
            case .general:
                return "General"
            case .health:
                return "Health"
            case .science:
                return "Science"
            case .sports:
                return "Sports"
            case .technology:
                return "Technology"
            }
        }
    }
}
