//
//  AppError.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

enum AppError: Error {
    case networkError(NetworkError)
    case decodeError(DecodeError)
    case error(Error)
    case defaultError
    
    init(_ value: Error) {
        self = .error(value)
    }
    
    var description: String {
        switch self {
        case .networkError(let error):
            return error.description
        case .decodeError(let error):
            return error.description
        case .error(let error):
            return error.localizedDescription
        case .defaultError:
            return ""
        }
    }
}

