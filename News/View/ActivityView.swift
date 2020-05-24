//
//  ActivityView.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import TinyConstraints

final class ActivityView: UIView {
    // MARK: - Views
    
    let activityIndicator = UIActivityIndicatorView()
    private(set) var centerY: Constraint?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        centerY = activityIndicator.centerYToSuperview()
        activityIndicator.centerXToSuperview()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .black
        backgroundColor = UIColor.white.withAlphaComponent(0.75)
    }
    
    // MARK: -
    
    var isAnimating: Bool {
        get {
            return activityIndicator.isAnimating
        }
        set {
            if newValue {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
}
