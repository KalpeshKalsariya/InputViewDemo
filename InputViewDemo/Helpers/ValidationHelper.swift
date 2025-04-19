//
//  ValidationHelper.swift
//  InputViewDemo
//
//  Created by  Kalpesh on 19/04/25.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
}
