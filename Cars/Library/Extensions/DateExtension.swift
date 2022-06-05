//
//  DateExtension.swift
//  Cars
//
//  Created by Vikas Kumar on 08/03/22.
//

import Foundation

extension Date {
    
    func isCurrentYear() -> Bool {
        let year = Calendar.current.component(.year, from: self)
        let currentYear = Calendar.current.component(.year, from: Date())
        return year == currentYear
    }
    
    func formattedDateString(_ format : String) -> String  {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .init(identifier: "en_US")
        dateFormatter.timeZone = .init(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    static func formattedDate(_ date : String, _ format : String) -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .init(identifier: "en_US")
        dateFormatter.timeZone = .init(identifier: "UTC")
        if let date = dateFormatter.date(from: date) {
            return date
        } else {
            return Date()
        }
    }
    
    
    static func isDateFormatSupported(with date: String, to format: String) -> Bool {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .init(identifier: "en_US")
        dateFormatter.timeZone = .init(identifier: "UTC")
        if let _ = dateFormatter.date(from: date) {
            return true
        }
        return false
    }
}
