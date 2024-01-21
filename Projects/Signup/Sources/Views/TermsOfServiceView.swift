//
//  TermsOfServiceView.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/20/24.
//

import SwiftUI

import Common
import NicknameSetting
import ComposableArchitecture

public struct TermsOfServiceView: View {
    @Environment(\.dismiss) var dismiss
    
    private let store: StoreOf<TermsOfServiceFeature>
    @State private var goToNext: Bool = false
    public init(store: StoreOf<TermsOfServiceFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                    makeCheckView(isCheck: viewStore.isAllCheck, text: "전체 동의", isAllCheckView: true) {
                        viewStore.send(.allCheckButtonTapped)
                    }
                    GrayDivider()
                    makeCheckView(isCheck: viewStore.isServiceCheck, text: "[필수] 서비스 이용약관 동의") {
                        viewStore.send(.serviceCheckButtonTapped)
                    }
                    makeCheckView(isCheck: viewStore.isInfoCheck, text: "[필수] 개인정보 수집·이용 동의") {
                        viewStore.send(.infoCheckButtonTapped)
                    }
                    makeCheckView(isCheck: viewStore.isAgeCheck, text: "[필수] 만 14세 이상 회원입니다.") {
                        viewStore.send(.ageCheckButtonTapped)
                    }
                }
                Spacer()
                RectangleBottomButton(isEnable: viewStore.$isPossibleNext, text: "다음") {
                    goToNext.toggle()
                }
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
            .navigationDestination(isPresented: $goToNext) {
                NicknameSettingView()
            }
        }
        
        
        
    }
    
    private func makeCheckView(
        isCheck: Bool,
        text: String,
        isAllCheckView: Bool = false,
        completion: @escaping () -> Void
    ) -> some View {
        return HStack {
            Image(asset: isCheck ? CommonAsset.checkOffIcon20px : CommonAsset.checkOnIcon20px)
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
