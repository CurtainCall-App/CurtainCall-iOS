//
//  RectangleBottomButton.swift
//  Common
//
//  Created by 김민석 on 1/14/24.
//

import SwiftUI

public struct RectangleBottomButton: View {
    
    public enum ButtonStateType {
        case enable
        case disable
    }
    
    
    private let text: String
    private let state: ButtonStateType
    
    public init(text: String, state: ButtonStateType) {
        self.text = text
        self.state = state
    }
    
    public var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.subTitle4)
            .foregroundStyle(Color(asset: state == .enable ? CommonAsset.hex0D1327 : CommonAsset.hexC6C8CD))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color(asset: state == .enable ? CommonAsset.hexD4C6FD : CommonAsset.hexF1F1F5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 20)
    }
}
