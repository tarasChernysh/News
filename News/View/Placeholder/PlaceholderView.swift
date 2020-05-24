//
//  PlaceholderView.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Configure
    
    func configure() {
        titleLabel.text = "Random user"
        descriptionLabel.text = "You haven't had random users yet"
        imageView.image = R.image.emptyList()
    }
    
    // MARK: - Setup
    
    private func setup() {
        Bundle.main.loadNibNamed("PlaceholderView", owner: self, options: nil) // R.nib.placeholderView.name
        setupLayout(for: contentView)
    }
    
    private func setupLayout(for contentView: UIView) {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
