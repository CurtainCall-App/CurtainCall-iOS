//
//  RectangleBottomButton.swift
//  Common
//
//  Created by 김민석 on 1/14/24.
//

import SwiftUI

public struct RectangleBottomButton: View {
    
    private let text: String
    private let completion: () -> Void
    
    @Binding private var isEnable: Bool
    
    public init(isEnable: Binding<Bool>, text: String, completion: @escaping () -> Void) {
        self._isEnable = isEnable
        self.text = text
        self.completion = completion
    }
    
    public var body: some View {
        Button(action: {
            completion()
        }, label: {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.subTitle4)
                .foregroundStyle(Color(asset: isEnable ? CommonAsset.white : CommonAsset.hexC6C8CD))
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color(asset: isEnable ? CommonAsset.hex0D1327 : CommonAsset.hexF1F1F5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
        .disabled(!isEnable)
    }
}
