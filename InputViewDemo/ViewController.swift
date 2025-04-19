//
//  ViewController.swift
//  InputViewDemo
//
//  Created by  Kalpesh on 19/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    var inputTextFields: [UITextField] = []
    
    // Fields as an array of FormFieldType enum
    var fields: [FormField] = [
        FormField(type: .fullName, text: nil, error: nil, isRequired: true),
        FormField(type: .email, text: nil, error: nil, isRequired: true),
        FormField(type: .phone, text: nil, error: nil),
        FormField(type: .address, text: nil, error: nil),
        FormField(type: .company, text: nil, error: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple Form"
        view.backgroundColor = .white
        
        setupTableView()
        setupSubmitButton()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomInputCell.self, forCellReuseIdentifier: CustomInputCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
    
    func createToolbar(for index: Int) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let prevButton = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(goToPrevious))
        prevButton.tag = index

        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(goToNext))
        nextButton.tag = index

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))

        toolbar.setItems([prevButton, nextButton, spacer, doneButton], animated: false)
        return toolbar
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func goToPrevious(_ sender: UIBarButtonItem) {
        let currentIndex = sender.tag
        let previousIndex = currentIndex - 1

        if previousIndex >= 0 {
            inputTextFields[previousIndex].becomeFirstResponder()
        }
    }

    @objc private func goToNext(_ sender: UIBarButtonItem) {
        let currentIndex = sender.tag
        let nextIndex = currentIndex + 1

        if nextIndex < inputTextFields.count {
            inputTextFields[nextIndex].becomeFirstResponder()
        }
    }
    
    private func setupSubmitButton() {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func submitTapped() {
        view.endEditing(true)
        var hasError = false
        
        var formData: [FormFieldType: String] = [:]
        
        for i in 0..<fields.count {
            let text = fields[i].text ?? ""
            if fields[i].isRequired && text.isEmpty {
                fields[i].error = "\(fields[i].type.placeholder) is required"
                hasError = true
            }else if fields[i].type == .email && !text.isEmpty && !isValidEmail(text) {
                // Email regex validation
                fields[i].error = "Invalid email format"
                hasError = true
            }else {
                fields[i].error = nil
            }
        }
        
        tableView.reloadData()
        
        if !hasError {
            for field in fields {
                formData[field.type] = field.text ?? ""
            }
            print("✅ Submitted:", formData)
            
            if let fullName = formData[.fullName] {
                print("Full Name: \(fullName)")  // Data for Full Name text field
            }
            
            if let email = formData[.email] {
                print("Email: \(email)")  // Data for Email text field
            }
            
            // If you need data for the 'Company' text field:
            if let company = formData[.company] {
                print("Company: \(company)")  // Data for Company text field
            }
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomInputCell.identifier, for: indexPath) as? CustomInputCell else {
            return UITableViewCell()
        }
        
        let field = fields[indexPath.row]
        let isRequired = field.isRequired
        let placeholder = field.type.placeholder
        let error = field.error
        
        cell.configure(placeholder: placeholder, isRequired: isRequired, text: field.text, error: error)
        
        cell.inputViewField.textField.tag = indexPath.row
//        cell.inputViewField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        cell.inputViewField.textField.delegate = self
        cell.inputViewField.textField.inputAccessoryView = createToolbar(for: cell.inputViewField.textField.tag)
        
        if !inputTextFields.contains(cell.inputViewField.textField) {
            inputTextFields.append(cell.inputViewField.textField)
        }
        
        return cell
    }
    
    @objc private func textChanged(_ textField: UITextField) {
        let index = textField.tag
        fields[index].text = textField.text
        fields[index].error = nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = textField.tag
        fields[index].text = textField.text
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextIndex = textField.tag + 1
        if nextIndex < inputTextFields.count {
            inputTextFields[nextIndex].becomeFirstResponder()
        } else {
            dismissKeyboard()
        }
        return true
    }
}

