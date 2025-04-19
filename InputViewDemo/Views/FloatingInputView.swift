//
//  FloatingInputView.swift
//  InputViewDemo
//
//  Created by  Kalpesh on 19/04/25.
//

import UIKit
class FloatingInputView: UIView {

    let textField = UITextField()
    private let borderView = UIView()
    private let titleLabel = UILabel()
    private let errorLabel = UILabel()

    var isRequired: Bool = false {
        didSet {
            updatePlaceholder()  // Ensure the placeholder updates when `isRequired` changes
        }
    }
    
    var placeholder: String? {
        didSet { updatePlaceholder() }
    }

    var errorMessage: String? {
        didSet { updateErrorUI() }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // Setup border view
        borderView.layer.cornerRadius = 6
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.gray.cgColor
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)

        // Setup textField
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        textField.tintColor = .black
        borderView.addSubview(textField)

        // Setup titleLabel (floating placeholder)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .gray
        titleLabel.alpha = 0  // Initially hidden
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Setup errorLabel
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)

        // Constraints
        NSLayoutConstraint.activate([
            // Border View Constraints
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 44),

            // TextField Constraints
            textField.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -8),

            // Title Label Constraints (Floating Placeholder)
            titleLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: textField.topAnchor, constant: -18),

            // Error Label Constraints
            errorLabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updatePlaceholder() {
        // Update the title label based on placeholder and isRequired flag
        titleLabel.text = placeholder
        
        if isRequired {
            let attr = NSMutableAttributedString(
                string: placeholder ?? "",
                attributes: [.foregroundColor: UIColor.gray]
            )
            attr.append(NSAttributedString(string: " *", attributes: [.foregroundColor: UIColor.red]))
            textField.attributedPlaceholder = attr
        } else {
            textField.placeholder = placeholder
        }

        // If the text field already has text, show the floating label
        if let currentText = textField.text, !currentText.isEmpty {
            animateLabelUp()
        }
    }

    private func updateErrorUI() {
        let hasError = !(errorMessage?.isEmpty ?? true)
        errorLabel.isHidden = !hasError
        errorLabel.text = errorMessage
        borderView.layer.borderColor = hasError ? UIColor.red.cgColor : UIColor.gray.cgColor
    }

    @objc private func textChanged() {
        // Clear error while typing
        errorMessage = nil
        
        // Animate the label if the text field has content
        if let text = textField.text, !text.isEmpty {
            animateLabelUp()
        } else {
            animateLabelDown()
        }
    }

    private func animateLabelUp() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.alpha = 1
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -20).scaledBy(x: 0.9, y: 0.9)
        }
    }

    private func animateLabelDown() {
        // Only animate down if the text field is empty
        if textField.text?.isEmpty ?? true {
            UIView.animate(withDuration: 0.2) {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = .identity
            }
        }
    }
}
