//
//  With.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

@discardableResult
public func with<T>(_ value: T,
                    _ builder: (inout T) throws -> Void) rethrows -> T {
    var mutableValue = value
    try builder(&mutableValue)
    return mutableValue
}
