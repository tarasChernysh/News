//
//  News.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

struct News {
    let title: String
    let source: String
    let author: String?
    let description: String?
    let imageURLString: String?
    let publishedDate: String
    let url: URL?
}

extension News: Decodable {
    init(from decoder: Decoder) throws {
        self.init(try Response(from: decoder))
    }
}

