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
    
    func removeTags(from string: String) -> String {
        var urlString = self
        guard let regex = try? NSRegularExpression(pattern: "<[^>]+>") else { return self }
        return regex.stringByReplacingMatches(in: string, range: NSRange(string.startIndex..., in: string), withTemplate: "")
    }
    
    func extractUrlsWithoutTags() -> [String] {
        guard let regex = try? NSRegularExpression(pattern: "<[^>]+>") else { return [] }
        let stringWithoutTags = regex.stringByReplacingMatches(in: self, range: NSRange(self.startIndex..., in: self), withTemplate: "")
        let urls = stringWithoutTags.split(separator: " ")
                                     .map { String($0) }
                                     .filter { !$0.isEmpty }
        return urls
    }

}
