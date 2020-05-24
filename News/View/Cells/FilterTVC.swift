//
//  FilterTVC.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

class FilterTVC: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with item: FilterLauncher.Item) {
        titleLabel.text = item.title
    }
    
    func configure(with item: CategoryVC.Item) {
        titleLabel.text = item.title
    }
    
    func configure(with item: AllowedCountry) {
        titleLabel.textAlignment = .left
        let countryName = IsoCountryCodes.find(key: item.rawValue.uppercased())?.name ?? ""
        let flag = IsoCountries.flag(countryCode: item.rawValue.uppercased()) ?? ""
        titleLabel.text = countryName + flag
    }
}
