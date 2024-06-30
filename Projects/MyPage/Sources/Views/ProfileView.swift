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
            VStack(spacing: 16) {
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
                HStack(spacing: 6) {
                    Text(store.userInfo?.nickname ?? "")
                        .font(.subTitle2)
                        .foregroundStyle(.black)
                    Image(asset: CommonAsset.mypageEditIcon18px)
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

