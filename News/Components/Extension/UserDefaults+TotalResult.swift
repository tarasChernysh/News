//
//  UserDefaults+TotalResult.swift
//  News
//
//  Created by Taras Chernysh on 10/13/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

extension UserDefaults {
    var newsTotalResult: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    var availableCountNews: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    func removeNewsTotalResult() {
        removeObject(forKey: "newsTotalResult")
    }
    
    func removeNewsAvailableCountNews() {
        removeObject(forKey: "availableCountNews")
    }
    
    var categoryNewsTotalResult: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    var availableCountCategoryNews: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    func removeCategoryNewsTotalResult() {
        removeObject(forKey: "categoryNewsTotalResult")
    }
    
    func removeAvailableCountCategoryNews() {
        removeObject(forKey: "availableCountCategoryNews")
    }
}
