//
//  FilterLauncher.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

class FilterLauncher: NSObject {
    
    // MARK: - Properties
    
    private let blackView = UIView()
    private let tableView: UITableView = {
        let tw = UITableView()
        tw.backgroundColor = .white
        return tw
    }()
    var selectedItem: ((Item) -> Void)?
    private let items: [Item] = [.category, .country, .source]
    
    // MARK: - Init
    
    override init() {
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.filterTVC)
    }
    
    // MARK: - Helper
    
    func showFilters() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(tableView)
            
            let height: CGFloat = 200
            let y = window.frame.height - height
            tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.tableView.frame = CGRect(x: 0, y: y, width: self.tableView.frame.width, height: self.tableView.frame.height)
            }, completion: nil)
            
        }
    }
    
    // MARK: - Selector
    
    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.tableView.frame = CGRect(x: 0, y: window.frame.height, width: self.tableView.frame.width, height: self.tableView.frame.height)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension FilterLauncher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.filterTVC, for: indexPath)!
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose filter"
    }
  
}

// MARK: - UITableViewDelegate

extension FilterLauncher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleDismiss()
        selectedItem?(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension FilterLauncher {
    enum Item {
        case country
        case source
        case category
    
        var title: String {
            switch self {
            case .category:
                return "Category"
            case .country:
                return "Country"
            case .source:
                return "Source"
            }
        }
    }
}
