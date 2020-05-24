//
//  SourceTVC.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

class SourceTVC: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryAndCountryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    func configure(with source: SourceNews) {
        nameLabel.text = source.name
        categoryAndCountryLabel.text = source.countryName + ", " + source.category
        descriptionLabel.text = source.description
    }
}

