//
//  Common.swift
//  CasoPractivoEKT
//
//  Created by Yess development on 13/06/24.
//

import Foundation


extension Double
{
    func asCurrency() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        let decimalLocale: Locale = .init(identifier: "es_MX")
        formatter.numberStyle = .currency
        return  formatter.string(from: self as NSNumber) ?? "-"
    }
}
