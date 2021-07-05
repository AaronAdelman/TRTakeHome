//
//  StringExtensions.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import Foundation

extension String {
    var dateFromTimestamp: Date? {
        let inputDateFormatter: DateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let importedDate: Date? = inputDateFormatter.date(from: self)
        
        return importedDate
    }
    
    var formattedFromTimestamp: String {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "en_US")
        outputDateFormatter.dateStyle = .medium
        outputDateFormatter.timeStyle = .medium
        
        let importedDate: Date? = self.dateFromTimestamp
        debugPrint(#file, #function, importedDate as Any)
        if importedDate == nil {
            return "???"
        }
        let formattedDate = outputDateFormatter.string(from: importedDate!)
        debugPrint(#file, #function, formattedDate)

        return formattedDate
    }
    
}
