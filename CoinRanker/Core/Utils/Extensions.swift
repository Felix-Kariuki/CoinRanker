//
//  DoubleExtensions.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Foundation
import TimberIOS

extension Double {
    var formatDouble: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = self.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}


extension String {
    func toTwoDecimalPlaces() -> String {
        guard let value = Double(self) else { return self }
        return String(format: "%.2f", value)
    }
}

extension String {
    func formattedMarketCap() -> String {
        guard let number = Double(self) else { return self }

        switch number {
        case 1_000_000_000_000...:
            return String(format: "%.2fT", number / 1_000_000_000_000)
        case 1_000_000_000...:
            return String(format: "%.2fB", number / 1_000_000_000)
        case 1_000_000...:
            return String(format: "%.2fM", number / 1_000_000)
        case 1_000...:
            return String(format: "%.2fK", number / 1_000)
        default:
            return String(format: "%.2f", number)
        }
    }
}


extension Date {
    var timestamp: Int64 {
        Int64(self.timeIntervalSince1970)
    }
}
