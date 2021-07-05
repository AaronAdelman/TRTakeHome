//
//  StringExtensions.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import Foundation
import UIKit

extension String {
    var dateFromTimestamp: Date? {
        let inputDateFormatter: DateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let importedDate: Date? = inputDateFormatter.date(from: self)
        
        return importedDate
    }
    
    var formattedFromTimestamp: String {
        // NOTE:  This is not a good way of doing the formatting.  In a production setting, the specs would prompt a discussion about localization, including wonderful options Apple has added to its OSs.
        
        let importedDate: Date? = self.dateFromTimestamp
        
        if importedDate == nil {
            // Something went horribly wrong.  Complain to server person for changing the JSON formatting without warning.
            return ""
        }

        let SECONDS_PER_MINUTE = 60.0
        let SECONDS_PER_HOUR   = 60.0 * SECONDS_PER_MINUTE
        let SECONDS_PER_DAY    = 24.0 * SECONDS_PER_HOUR
        
        let now = Date()
        let interval = now.timeIntervalSince(importedDate!)
        
        if interval < 5.0 * SECONDS_PER_MINUTE {
            return "Now"
        }
        
        if interval < SECONDS_PER_HOUR {
            let minutes: Int = Int(floor(interval / SECONDS_PER_MINUTE))
            return "\(minutes) minutes ago"
        }
        
        if interval < SECONDS_PER_DAY {
            let hours: Int = Int(floor(interval / SECONDS_PER_HOUR))
            return "\(hours) hours ago"
        }
        
        if interval < 7.0 * SECONDS_PER_DAY {
            let days: Int = Int(floor(interval / SECONDS_PER_DAY))
            return "\(days) days ago"
        }
        
        let outputDateFormatter = ISO8601DateFormatter()
        outputDateFormatter.formatOptions = [.withFullDate]
        
        let formattedDate = outputDateFormatter.string(from: importedDate!)
        debugPrint(#file, #function, formattedDate)

        return formattedDate
    }
}


// From https://stackoverflow.com/questions/25983558/stripping-out-html-tags-from-a-string
extension String {
    func withoutHTMLTags() -> String {
        let str = self.replacingOccurrences(of: "<style>[^>]+</style>", with: "", options: .regularExpression, range: nil)
        return str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
