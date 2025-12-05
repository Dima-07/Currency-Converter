//
//  ConverterModel.swift
//  Currency Converter
//
//  Created by Дима Кондратенко on 05.12.2025.
//

import Foundation

// MARK: - Валюты

enum Currency: Int {
    case rub = 0
    case usd = 1
    case eur = 2
    
    var symbol: String {
        switch self {
        case .rub: return "₽"
        case .usd: return "$"
        case .eur: return "€"
        }
    }
}


final class ConverterModel {
    
    // MARK: - Бизнес-Логика
    
    private let rates: [Currency: Double] = [
        .usd: 1.0,
        .eur: 0.85,
        .rub: 76
    ]
    
    func convert(amount: Double, from fromCurrency: Currency, to toCurrency: Currency) -> Double? {
        
        guard let fromRate = rates[fromCurrency],
              let toRate = rates[toCurrency] else {
            return nil
        }
        
        let amountInBaseCurrency = amount / fromRate
        let finalAmount = amountInBaseCurrency * toRate
        
        return finalAmount
    }
}
