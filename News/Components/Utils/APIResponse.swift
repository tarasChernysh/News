//
//  APIResponse.swift
//  News
//
//  Created by Taras Chernysh on 10/14/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

struct APIResponse<Value> {
    let sources: Value
    
    func map<T>(_ transform: (Value) throws -> T) rethrows -> APIResponse<T> {
        let newData = try transform(sources)
        return APIResponse<T>(sources: newData)
    }
}

extension APIResponse: Decodable where Value: Decodable {}
