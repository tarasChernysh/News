//
//  SearchVC.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import SafariServices
import ReactiveSwift
import ReactiveCocoa

class SearchVC: BaseVC {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let searchText = MutableProperty("")
    private var searchVC: UISearchController?
    private var paginationService = NewsPaginationService(state: .searchNews(SearchQuestion(body: "")))
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
    
    // MARK: - Setup
    
    private func setup() {
        title = "Search news"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        reactive.makeBindingTarget { vc, text in
            vc.paginationService = NewsPaginationService(state: .searchNews(SearchQuestion(body: text)))
            vc.paginationService.searchNews()
            vc.reactive.activity <~ vc.paginationService.isFetchInProgress
            vc.reactive.errors <~ vc.paginationService.fetchedError.signal
            vc.reactive.endListNews <~ vc.paginationService.endNews.signal.skipNil()
            
            
            vc.reactive.makeBindingTarget { controller, _ in
                controller.tableView.reloadData()
                } <~ vc.paginationService.successFetch.signal.skip(while: { $0 == false })
            
        } <~ searchText.signal
        
        createSearhVC()
        setupTableView()
    }
    
    // MARK: - Selectors
    
    @objc func handleRefresh() {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    // MARK: - Helper nethod
    
    private func createSearhVC() {
        searchVC = UISearchController(searchResultsController: nil)
        searchVC?.dimsBackgroundDuringPresentation = false
        searchVC?.searchBar.delegate = self
        searchVC?.searchBar.barTintColor = #colorLiteral(red: 0.2008563355, green: 0.5135880239, blue: 0.6235294342, alpha: 1)
        searchVC?.searchBar.tintColor = .white
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.tableHeaderView = searchVC?.searchBar
        tableView.addSubview(refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.newsTVC)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension SearchVC: UITableViewDataSource {
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
            paginationService.searchNews()
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchVC: UITableViewDelegate {
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

// MARK: - UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText.value = text
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        paginationService.removeAll()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText.value = text
        }
    }
}

