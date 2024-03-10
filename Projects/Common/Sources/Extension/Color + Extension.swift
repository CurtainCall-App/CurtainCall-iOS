//
//  Color + Extension.swift
//  Common
//
//  Created by 김민석 on 1/12/24.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

public extension Color {
    static let primary1 = Color(hex: 0x0D1327)
    static let primary2 = Color(hex: 0xD4C6FD)
    static let gray1 = Color(hex: 0x1C1E21)
    static let gray2 = Color(hex: 0x32363D)
    static let gray3 = Color(hex: 0x464B51)
    static let gray4 = Color(hex: 0x71757C)
    static let gray5 = Color(hex: 0xA1A5AE)
    static let gray6 = Color(hex: 0xC6C8CD)
    static let gray7 = Color(hex: 0xE5E7EB)
    static let gray8 = Color(hex: 0xF1F1F5)
    static let gray9 = Color(hex: 0xF8F8F8)
    static let systemRed = Color(hex: 0xFF334B)
    static let systemGreen = Color(hex: 0x00C271)
    static let systemYellow = Color(hex: 0xFFD600)
}
