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

extension Color {
    static let primary1 = Color("hex0D1327")
    static let gray1 = Color("hex1C1E21")
    static let gray2 = Color("hex32363D")
    static let gray3 = Color("hex464B51")
    static let gray4 = Color("hex71757C")
    static let gray5 = Color("hexA1A5AE")
    static let gray6 = Color("hexC6C8CD")
    static let gray7 = Color("hexE5E7EB")
    static let gray8 = Color("hexF1F1F5")
    static let gray9 = Color("hexF8F8F8")
    static let systemRed = Color("hexFF334B")
    static let systemGreen = Color("hex00C271")
    static let systemYellow = Color("hexFFD600")
}
