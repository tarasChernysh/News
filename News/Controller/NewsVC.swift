//
//  ViewController.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import SafariServices

final class NewsVC: BaseVC {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let filterLauncher = FilterLauncher()
    private lazy var paginationService = NewsPaginationService(state: .general)
    let refreshControl: UIRefreshControl = {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeValueFromUserDefaultsForCorrectWorkInNewCategoryVC()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Setup
    
    private func setup() {
        reactive.activity <~ paginationService.isFetchInProgress
        reactive.errors <~ paginationService.fetchedError.signal
        reactive.endListNews <~ paginationService.endNews.signal.skipNil()
        reactive.makeBindingTarget { vc, _ in
            vc.tableView.reloadData()
        } <~ paginationService.successFetch.signal.skip(while: { $0 == false })
        fetchFirstNews()
        setupTableView()
        setupNavBarButtons()
        setupTitle()
        observeCloseFilterLauncher()
    }
    
    // MARK: - Selectors
    
    @objc func didTappedSearchBarButtonItem() {
        let coordinator = AppCoordinator(viewController: self, state: .search)
        coordinator.start()
    }
    
    @objc func didTappedMoreBarButtonItem() {
        filterLauncher.showFilters()
    }

    @objc func handleRefresh() {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Setups
    
    private func setupNavBarButtons() {
        let searchImage = R.image.search_icon()?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(didTappedSearchBarButtonItem))
        
        let moreImage = R.image.nav_more_icon()?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(didTappedMoreBarButtonItem))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem ,searchBarButtonItem]
    }
    
    private func setupTitle() {
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = "Top news in Ukraine"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    private func fetchFirstNews() {
        paginationService.fetchNews()
    }
    
    private func setupTableView() {
        tableView.addSubview(refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.newsTVC)
    }
    
    private func removeValueFromUserDefaultsForCorrectWorkInNewCategoryVC() {
        UserDefaults.standard.removeCategoryNewsTotalResult()
        UserDefaults.standard.removeAvailableCountCategoryNews()
    }
    
    private func observeCloseFilterLauncher() {
        filterLauncher.selectedItem = { item in
            switch item {
            case .country:
                let coordinator = AppCoordinator(viewController: self, state: .country)
                coordinator.start()
            case .source:
                let coordinator = AppCoordinator(viewController: self, state: .source)
                coordinator.start()
            case .category:
                let coordinator = AppCoordinator(viewController: self, state: .category)
                coordinator.start()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationService.currentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.newsTVC, for: indexPath)!
        cell.configure(with: paginationService.news(at: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == paginationService.currentCount - 1 {
            paginationService.fetchNews()
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = paginationService.news(at: indexPath.row)
        guard let url = news.url else { return }
        let safaryVC = SFSafariViewController(url: url)
        present(safaryVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
