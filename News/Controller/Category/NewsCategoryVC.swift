//
//  NewsCategoryVC.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import SafariServices

final class NewsCategoryVC: BaseVC {
    enum State {
        case category(CategoryVC.Item)
        case country(AllowedCountry)
        
        var title: String {
            switch self {
            case .category(let category):
                return "\(category.title) news"
            case .country(let country):
                if let countryName = IsoCountryCodes.find(key: country.rawValue.uppercased())?.name,
                    let countryFlag = IsoCountryCodes.find(key: country.rawValue.uppercased())?.flag {
                    return "\(countryName)\(countryFlag) news"
                }
                return "News"
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
 
    var state: State = .country(.ua)
    private var paginationService: NewsPaginationService?
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .gray
        return refreshControl
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        print("deinit \(self)")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func handleRefresh() {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Setup
    
    private func setup() {
        switch state {
        case .category(let category):
            paginationService = NewsPaginationService(state: .category(category))
        case .country(let country):
            paginationService = NewsPaginationService(state: .country(country))
        }
        guard let paginationService = paginationService else { return }
        reactive.activity <~ paginationService.isFetchInProgress
        reactive.errors <~ paginationService.fetchedError.signal
        reactive.endListNews <~ paginationService.endNews.signal.skipNil()
        reactive.makeBindingTarget { vc, _ in
            vc.tableView.reloadData()
            } <~ paginationService.successFetch.signal.skip(while: { $0 == false })
        fetchNews()
        setupTableView()
        setupTitle()
    }
    
    // MARK: - Setups
   
    private func setupTitle() {
        title = state.title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func fetchNews() {
        switch state {
        case .category:
            paginationService?.fetchCategoryNews()
        case .country:
            paginationService?.fetchCountryNews()
        }
    }
    
    private func setupTableView() {
        tableView.addSubview(refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.newsTVC)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension NewsCategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationService?.currentCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.newsTVC, for: indexPath)!
        guard let service = paginationService else { return cell }
        cell.configure(with: service.news(at: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let service = paginationService else { return }
        if indexPath.row == service.currentCount - 1 {
            switch state {
            case .category:
                service.fetchCategoryNews()
            case .country:
                service.fetchCountryNews()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsCategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = paginationService?.news(at: indexPath.row) else { return }
        guard let url = news.url else { return }
        let safaryVC = SFSafariViewController(url: url)
        present(safaryVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
