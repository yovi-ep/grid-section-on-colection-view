//
//  ExtensionString.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 06/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import Foundation

enum StringToDateType: String, CaseIterable {
    case ddMMMyyy = "dd-MMM-yyy"
    case yyyyMMdd = "yyyyMMdd"
}

extension String {
    func amountFormatter(useCurrency: Bool, useComma: Bool) -> String {
        let converter = NumberFormatter()
        converter.decimalSeparator = "."
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "id-ID")
        formatter.currencySymbol = useCurrency ? "Rp " : ""
        if useComma { formatter.minimumFractionDigits = 2 }

        guard let amount = converter.number(from: self),
            let newAmount = formatter.string(from: amount) else {
            return "-"
        }
        return newAmount
    }
    
    func dateFormatterToString(fromType: StringToDateType, toType: StringToDateType) -> String {
        let dateFromFormatter = DateFormatter()
        dateFromFormatter.dateFormat = fromType.rawValue
        let dateToFormatter = DateFormatter()
        dateToFormatter.dateFormat = toType.rawValue
        
        if let stringToDate = dateFromFormatter.date(from: self) {
            let newDateToString = dateToFormatter.string(from: stringToDate)
            return newDateToString
            
        }
        return "-"
    }
}
