//
//  NicknameSettingView.swift
//  NicknameSetting
//
//  Created by 김민석 on 1/21/24.
//

import SwiftUI

import Common
import ComposableArchitecture

public struct NicknameSettingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appRootManager: AppRootManager
    
    private let store: StoreOf<NicknameSettingFeature>
    
    public init(store: StoreOf<NicknameSettingFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Spacer().frame(height: 30)
                Text("커튼콜에서 사용할 닉네임을\n설정해 주세요.")
                    .font(.subTitle1)
                    .foregroundStyle(.black)
                    .lineSpacing(1.3)
                Spacer().frame(height: 14)
                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        Image(asset: viewStore.isValidCount ? CommonAsset.checkIconGreen14px : CommonAsset.checkIconGray14px)
                        Text("공백없이 1자~15자 사이로 작성")
                            .font(.body3)
                            .foregroundStyle(Color(asset: CommonAsset.hex71757C))
                        Spacer()
                    }
                    HStack(spacing: 6) {
                        Image(asset: viewStore.isValidRegex ? CommonAsset.checkIconGreen14px : CommonAsset.checkIconGray14px)
                        Text("한글, 영문, 숫자 자유롭게 사용 가능")
                            .font(.body3)
                            .foregroundStyle(Color(asset: CommonAsset.hex71757C))
                        Spacer()
                    }
                }
                Spacer().frame(height: 40)
                HStack {
                    TextField("닉네임을 입력해주세요.", text: viewStore.$nicknameText)
                        .padding()
                        .frame(height: 45)
                        .background {
                            Color(asset: CommonAsset.hexF8F8F8)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer().frame(width: 12)
                    Text("중복 확인")
                        .font(.body2_M)
                        .foregroundStyle(Color(
                            asset: viewStore.isValidCount && viewStore.isValidRegex ? CommonAsset.white : CommonAsset.hexC6C8CD
                        ))
                        .frame(width: 96, height: 45)
                        .background {
                            Color(
                                asset: viewStore.isValidCount && viewStore.isValidRegex ? CommonAsset.hex0D1327 : CommonAsset.hexF1F1F5
                            )
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            viewStore.send(.duplicatedCheckButtonTapped)
                        }
                }
                Spacer().frame(height: 12)
                if viewStore.isTappedDuplicatedButton {
                    Text(viewStore.isPossibleNickname ? "사용 가능한 닉네임이에요:)" : "이미 동일한 닉네임이 있어요:(\n다른 닉네임을 입력해주세요!")
                        .font(.body3)
                        .foregroundStyle(Color(asset: viewStore.isPossibleNickname ? CommonAsset.hex00C271 : CommonAsset.hexFF334B))
                        .padding(.leading, 14)
                }
                Spacer()
                RectangleBottomButton(isEnable: viewStore.$isPossibleNickname, text: "회원가입 완료") {
                    viewStore.send(.signupButtonTapped)
                }
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 20)
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
            .onChange(of: viewStore.appRoot) { _, newValue in
                appRootManager.currentRoot = newValue
            }
        }
    }
}
