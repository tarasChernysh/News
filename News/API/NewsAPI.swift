//
//  NewsAPI.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation
import Moya

enum NewsAPI {
    case list(LimitOffset)
    case listForCountry(LimitOffset, AllowedCountry)
    case listForCategory(LimitOffset, CategoryVC.Item)
    case fetchSources
    case searchNews(LimitOffset, SearchQuestion)
}

extension NewsAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .list, .listForCategory, .listForCountry, .fetchSources, .searchNews:
            return URL(string: "https://newsapi.org/v2")!
        }
    }
    
    var path: String {
        switch self {
        case .list, .listForCategory, .listForCountry, .searchNews:
            return "/top-headlines"
        case .fetchSources:
            return "/sources"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list, .listForCategory, .listForCountry, .fetchSources, .searchNews:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .listForCountry(let pagination, let country):
            return .requestParameters(parameters: ["country": country.rawValue,
                                                   "apiKey": Constant.apiKey,
                                                   "page": pagination.page,
                                                   "pageSize": pagination.limit],
                                      encoding: URLEncoding.default)
        case .list(let pagination):
            return .requestParameters(parameters: ["country": "ua",
                                                   "apiKey": Constant.apiKey,
                                                   "page": pagination.page,
                                                   "pageSize": pagination.limit],
                                      encoding: URLEncoding.default)
        case .listForCategory(let pagination, let category):
            return .requestParameters(parameters: ["country": "ua",
                                                   "category": category.rawValue,
                                                   "apiKey": Constant.apiKey,
                                                   "page": pagination.page,
                                                   "pageSize": pagination.limit],
                                      encoding: URLEncoding.default)
        case .fetchSources:
            return .requestParameters(parameters: ["language": "en",
                                                   "country": "us",
                                                   "apiKey": Constant.apiKey],
                                      encoding: URLEncoding.default)
        case .searchNews(let pagination, let question):
            return .requestParameters(parameters: ["q": question.body,
                                                   "apiKey": Constant.apiKey,
                                                   "page": pagination.page,
                                                   "pageSize": pagination.limit],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

