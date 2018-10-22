//
//  Swift+FormatISODate.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {

    func formatDateFromISO() -> String {
        var date: Wrapped { return self ?? "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFromISOString = dateFormatter.date(from: date)
        guard let unwrappedDateFromString = dateFromISOString else { return "" }

        let secondDateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        secondDateFormatter.dateStyle = .medium
        secondDateFormatter.timeStyle = .short

        let stringDate = secondDateFormatter.string(from: unwrappedDateFromString)
        return stringDate
    }

}
