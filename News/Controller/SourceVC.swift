//
//  SourceVC.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import SafariServices
import ReactiveCocoa
import ReactiveSwift

final class SourceVC: BaseVC, UseCasesConsumer {
    typealias UseCases = NetworkUseCase
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    
    private let isFetchInProgress = MutableProperty(false)
    private var sources: [SourceNews] = []
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
    
    // MARK: - Setup
    
    private func setup() {
        useCases = NetworkService()
        
        reactive.activity <~ isFetchInProgress
        setupTableView()
        setupTitle()
        fetchSource()
    }
    
    // MARK: - Selectors
    
    @objc func handleRefresh() {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Setups
    
    private func setupTitle() {
        title = "All sources"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupTableView() {
        tableView.addSubview(refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.sourceTVC)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Helper method
    
    private func fetchSource() {
        self.isFetchInProgress.value = true
        useCases.fetchSources().take(duringLifetimeOf: self).startWithResult { [weak self] result in
            guard let self = self else { return }
            self.isFetchInProgress.value = false
            switch result {
            case .success(let array):
                self.sources = array
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension SourceVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sourceTVC, for: indexPath)!
        cell.configure(with: sources[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SourceVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let source = sources[indexPath.row]
        let safaryVC = SFSafariViewController(url: source.url)
        present(safaryVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    

