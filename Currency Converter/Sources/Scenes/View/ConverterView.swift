//
//  ConverterView.swift
//  Currency Converter
//
//  Created by Дима Кондратенко on 05.12.2025.
//

import UIKit

final class ConverterView: UIView {
    
    weak var delegate: ConverterViewDelegate?
    
    // MARK: - Views
    
    lazy var amountTextField: UITextField = {
        let field  = UITextField()
        field.placeholder = "Введите сумму"
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
        field.textAlignment = .center
        
        field.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
        
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    lazy var fromSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["RUB", "USD", "EUR"])
        control.selectedSegmentIndex = 0
        
        control.addTarget(self, action: #selector(inputChanged), for: .valueChanged)
        
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
    
    lazy var toSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["RUB", "USD", "EUR"])
        control.selectedSegmentIndex = 1
        
        control.addTarget(self, action: #selector(inputChanged), for: .valueChanged)
        
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите данные"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemGreen
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(amountTextField)
        addSubview(fromSegmentedControl)
        addSubview(toSegmentedControl)
        addSubview(resultLabel)
    }
    
    private func setupLayout() {
        let margin = Metric.spacing
        
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            amountTextField.heightAnchor.constraint(equalToConstant: Metric.fieldHeight),
            
            fromSegmentedControl.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: margin),
            fromSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            fromSegmentedControl.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            
            toSegmentedControl.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: margin),
            toSegmentedControl.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 5),
            toSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            resultLabel.topAnchor.constraint(equalTo: fromSegmentedControl.bottomAnchor, constant: margin * 2),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
        ])
    }
    
    // MARK: - Target-Action (Уведомление Controller'а)

    @objc func inputChanged() {
        delegate?.converterInputDidChange()
    }
    
    // Controller будет вызывать этот метод, чтобы обновить UI
    func updateResult(text: String) {
        resultLabel.text = text
    }
}

// MARK: - ConverterViewDelegate Protocol

protocol ConverterViewDelegate: AnyObject {
    func converterInputDidChange()
}

// MARK: - Constants

extension ConverterView {
    enum Metric {
        static let spacing: CGFloat = 20
        static let fieldHeight: CGFloat = 44
    }
}
