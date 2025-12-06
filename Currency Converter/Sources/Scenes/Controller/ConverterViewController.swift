//
//  ViewController.swift
//  Currency Converter
//
//  Created by Дима Кондратенко on 05.12.2025.
//

import UIKit

final class ConverterViewController: UIViewController {
    
    // MARK: - MVC Components
    
    private var converterView: ConverterView {
        guard let convertedView = view as? ConverterView else {
            fatalError("The view is not an instance of ConverterView as expected.")
        }
        return convertedView
    }
    
    private let converterModel = ConverterModel()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view = ConverterView()
        title = "Конвертер валют"
        
        converterView.delegate = self
        setupKeyboardDismiss()
    }
    
    // MARK: - Setup
    
    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Coordination Logic
    
    private func convertCurrency() {
        guard let amountText = converterView.amountTextField.text,
              let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")) else {
            converterView.updateResult(text: "Введите корректную сумму")
            return
        }
        
        let fromIndex = converterView.fromSegmentedControl.selectedSegmentIndex
        let toIndex = converterView.toSegmentedControl.selectedSegmentIndex
        
        guard let fromCurrency = Currency(rawValue: fromIndex),
              let toCurrency = Currency(rawValue: toIndex) else {
            return
        }
        
        let resultAmount = converterModel.convert(
            amount: amount,
            from: fromCurrency,
            to: toCurrency)
        
        if let result = resultAmount {
            let formattedAmount = String(format: "%.2f", result)
            let finalString = "\(formattedAmount) \(toCurrency.symbol)"
            
            converterView.updateResult(text: finalString)
        } else {
            converterView.updateResult(text: "Ошибка конвертации")
        }
    }
}

extension ConverterViewController: ConverterViewDelegate {
    func converterInputDidChange() {
        convertCurrency()
    }
}
