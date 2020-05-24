//
//  News+Response.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

extension News {
    struct Response: Decodable {
        let title: String
        let source: String
        let author: String?
        let description: String?
        let urlToImage: String?
        let publishedAt: String
        let urlPath: String
        
        
        private enum MainCodingKey: String, CodingKey {
            case title
            case source
            case author
            case description
            case urlToImage
            case publishedAt
            case url
        }
        
        private enum SourceCodingKey: String, CodingKey {
            case name
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: MainCodingKey.self)
            title = try container.decode(String.self, forKey: .title)
            author = try container.decodeIfPresent(String.self, forKey: .author)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
            publishedAt = try container.decode(String.self, forKey: .publishedAt)
            urlPath = try container.decode(String.self, forKey: .url)
            
            let nestedConteiner = try container.nestedContainer(keyedBy: SourceCodingKey.self, forKey: .source)
            source = try nestedConteiner.decode(String.self, forKey: .name)
        }
    }
    
    init(_ response: Response) {
        let publishAtDate = DateFormatter.publishedDate(date: response.publishedAt)
        self.init(title: response.title,
                  source: response.source,
                  author: response.author,
                  description: response.description,
                  imageURLString: response.urlToImage,
                  publishedDate: publishAtDate,
                  url: URL(string: response.urlPath))
    }
}
