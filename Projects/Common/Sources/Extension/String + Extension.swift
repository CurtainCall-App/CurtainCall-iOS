//
//  String + Extension.swift
//  Common
//
//  Created by 김민석 on 2/9/24.
//

import Foundation

public extension String {
    func isValidRegex(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
