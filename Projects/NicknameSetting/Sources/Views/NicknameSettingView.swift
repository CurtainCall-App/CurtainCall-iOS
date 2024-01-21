//
//  NicknameSettingView.swift
//  NicknameSetting
//
//  Created by 김민석 on 1/21/24.
//

import SwiftUI

import Common

public struct NicknameSettingView: View {
    @Environment(\.dismiss) var dismiss
    
    public init() { }
    
    public var body: some View {
        Text("닉네임 셋팅 뷰")
            .navigationTitle("회원가입")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(asset: CommonAsset.navigationBackIcon)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
    }
}
