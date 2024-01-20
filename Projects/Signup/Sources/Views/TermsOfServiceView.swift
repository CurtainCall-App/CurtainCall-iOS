//
//  TermsOfServiceView.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/20/24.
//

import SwiftUI

import Common

public struct TermsOfServiceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    public init() { }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 30)
            Text("커튼콜 서비스 이용을 위해\n약관 동의가 필요해요")
                .font(.subTitle1)
                .foregroundStyle(.black)
                .lineSpacing(1.3)
            Spacer().frame(height: 14)
            Text("아래 약관 내용에 동의 후 서비스 이용이 가능합니다.")
                .font(.body3)
                .foregroundStyle(Color(asset: CommonAsset.hex71757C))
            Spacer().frame(height: 40)
            VStack(alignment: .leading, spacing: 20) {
                makeCheckView(text: "전체 동의", isAllCheckView: true) {
                    print("1 Tap")
                }
                GrayDivider()
                makeCheckView(text: "[필수] 서비스 이용약관 동의") {
                    print("2 Tap")
                }
                makeCheckView(text: "[필수] 개인정보 수집·이용 동의") {
                    print("3 Tap")
                }
                makeCheckView(text: "[필수] 만 14세 이상 회원입니다.") {
                    print("4 Tap")
                }
            }
            Spacer()
            RectangleBottomButton(text: "다음", state: .disable)
                .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .navigationTitle("약관 동의")
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
    
    private func makeCheckView(
        text: String,
        isAllCheckView: Bool = false,
        completion: @escaping () -> Void
    ) -> some View {
        return HStack {
            Image(asset: CommonAsset.checkOnIcon20px)
                .onTapGesture {
                    completion()
                }
            Spacer().frame(width: 10)
            Text(text)
                .font(.body2_SB)
                .foregroundStyle(.black)
            if !isAllCheckView {
                Spacer()
                Text("보기")
                    .font(.body4)
                    .foregroundStyle(Color(asset: CommonAsset.hexA1A5AE))
            }
        }
    }
}
