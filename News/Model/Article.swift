//
//  Article.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

struct Article {
    let totalResults: Int
    let news: [News]
}

extension Article {
    struct Response: Decodable {
        let totalResults: Int
        let articles: [News.Response]
    }
    
    init(_ response: Response) {
        self.init(totalResults: response.totalResults, news: response.articles.map { News($0) })
    }
}
