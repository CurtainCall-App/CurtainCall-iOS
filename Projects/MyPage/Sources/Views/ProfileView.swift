//
//  ProfileView.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import SwiftUI

import Common

import ComposableArchitecture
import NukeUI

struct ProfileView: View {
    
    @Bindable private var store: StoreOf<ProfileFeature>
    
    @Environment(\.dismiss) var dismiss
    
    init(store: StoreOf<ProfileFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                if let imageURL = store.userInfo?.imageUrl {
                    LazyImage(url: URL(string: imageURL)) { state in
                        if let image = state.image {
                            image.resizable()
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fill)
                        } else {
                            ProgressView()
                        }
                    }
                } else {
                    Image(asset: CommonAsset.mypageDefaultProfile80px)
                }
                if store.modeType == .normal {
                    Spacer().frame(height: 16)
                    HStack(spacing: 6) {
                        Text(store.userInfo?.nickname ?? "")
                            .font(.subTitle2)
                            .foregroundStyle(.black)
                        Image(asset: CommonAsset.mypageEditIcon18px)
                            .onTapGestureRectangle {
                                store.send(.didTappedEditButton)
                            }
                    }
                } else {
                    Spacer().frame(height: 40)
                    HStack {
                        TextField("닉네임을 입력해주세요.", text: $store.nicknameText)
                            .padding()
                            .frame(height: 45)
                            .background(Color.gray9)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Spacer().frame(width: 12)
                        Text("중복 확인")
                            .font(.body2_M)
                            .foregroundStyle(Color(
                                asset: store.isValidCount && store.isValidRegex ? CommonAsset.white : CommonAsset.hexC6C8CD
                            ))
                            .frame(width: 96, height: 45)
                            .background {
                                Color(
                                    asset: store.isValidCount && store.isValidRegex ? CommonAsset.hex0D1327 : CommonAsset.hexF1F1F5
                                )
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                store.send(.duplicatedCheckButtonTapped)
                            }
                    }
                    Spacer().frame(height: 12)
                    if store.isTappedDuplicatedButton {
                        HStack {
                            Text(store.isPossibleNickname ? "사용 가능한 닉네임이에요:)" : "이미 동일한 닉네임이 있어요:(\n다른 닉네임을 입력해주세요!")
                                .font(.body3)
                                .foregroundStyle(Color(asset: store.isPossibleNickname ? CommonAsset.hex00C271 : CommonAsset.hexFF334B))
                                .padding(.leading, 14)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.top, 50)
            Spacer()
            RectangleBottomButton(isEnable: $store.enableComplete, text: "프로필 변경 완료") {
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .onAppear {
            store.send(.fetchUserInfo)
        }
        .navigationTitle("프로필 변경")
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

