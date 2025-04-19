//
//  FormField.swift
//  InputViewDemo
//
//  Created by  Kalpesh on 19/04/25.
//

import Foundation

struct FormField {
    var type: FormFieldType
    var text: String?
    var error: String?
    var isRequired: Bool = false
}

enum FormFieldType {
    case fullName
    case email
    case phone
    case address
    case company

    var placeholder: String {
        switch self {
        case .fullName: return "Full Name"
        case .email: return "Email"
        case .phone: return "Phone"
        case .address: return "Address"
        case .company: return "Company"
        }
    }
}
