//
//  SourceNews.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

struct SourceNews: Decodable {
    let id: String
    let name: String
    let description: String
    let category: String
    let country: String
    let url: URL
    
    var countryName: String {
        let countryName = IsoCountryCodes.find(key: country)?.name ?? ""
        let countryFlag = IsoCountryCodes.find(key: country)?.name ?? ""
        return "\(countryName)\(countryFlag)"
    }
}
