//
//  CustomInputCell.swift
//  InputViewDemo
//
//  Created by  Kalpesh on 19/04/25.
//

import UIKit

class CustomInputCell: UITableViewCell {

    static let identifier = "CustomInputCell"
    let inputViewField = FloatingInputView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        selectionStyle = .none
        contentView.addSubview(inputViewField)
        inputViewField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            inputViewField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            inputViewField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            inputViewField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            inputViewField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(placeholder: String, isRequired: Bool, text: String?, error: String?) {
        inputViewField.placeholder = placeholder
        inputViewField.isRequired = isRequired
        inputViewField.text = text
        inputViewField.errorMessage = error
    }
}
