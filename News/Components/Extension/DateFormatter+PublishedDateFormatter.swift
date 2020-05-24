//
//  DateFormatter+PublishedDateFormatter.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation

extension DateFormatter {
     public static func publishedDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dt = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "dd MMM, h:mm a"
        
        return dateFormatter.string(from: dt)
    }
}
