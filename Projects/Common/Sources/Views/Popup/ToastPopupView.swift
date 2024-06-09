//
//  ToastPopupView.swift
//  Common
//
//  Created by 김민석 on 1/12/24.
//

import SwiftUI

public struct ToastPopupView: View {
    
    public enum ToastType {
        case success
        case failed
        case basic
    }
    
    private let text: String
    private let type: ToastType
    
    public init(type: ToastType, text: String) {
        self.type = type
        self.text = text
    }
    
    public var body: some View {
        HStack {
            if type != .basic {
                Image(asset: type == .success ?
                      CommonAsset.toastSuccessIcon24px :
                        CommonAsset.toastFailedIcon24px
                )
                Spacer().frame(width: 12)
            }
            Text(text)
                .font(.body2_M)
                .foregroundStyle(Color.white)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18.5)
        .padding(.horizontal, 16)
        .background(Color(asset: CommonAsset.toastBackgroundGray))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        // TODO: padding 값 변경
        .padding(.horizontal, 20)
    }
}
