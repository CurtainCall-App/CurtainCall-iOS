//
//  RectangleBottomButton.swift
//  Common
//
//  Created by 김민석 on 1/14/24.
//

import SwiftUI

public struct RectangleBottomButton: View {
    
    private let text: String
    
    @Binding private var isEnable: Bool
    
    public init(isEnable: Binding<Bool>, text: String) {
        self._isEnable = isEnable
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.subTitle4)
            .foregroundStyle(Color(asset: isEnable ? CommonAsset.hexFFFCAB : CommonAsset.hexC6C8CD))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color(asset: isEnable ? CommonAsset.hex0D1327 : CommonAsset.hexF1F1F5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
