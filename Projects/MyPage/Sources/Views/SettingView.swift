//
//  SettingView.swift
//  MyPage
//
//  Created by 김민석 on 6/9/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct SettingView: View {
    private let store: StoreOf<SettingFeature>
    
    @Environment(\.dismiss) var dismiss
    
    init(store: StoreOf<SettingFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("계정")
                    .font(.subTitle4)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
            
            HStack {
                Text("로그아웃")
                    .font(.body2_M)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("계정 삭제")
                    .font(.body2_M)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Color.gray9.frame(height: 10).padding(.vertical, 10)
            
            HStack {
                Text("정보")
                    .font(.subTitle4)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("개인정보 처리방침")
                    .font(.body2_M)
                    .foregroundStyle(.black)
                Spacer()
                Text("보기")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("서비스 이용약관")
                    .font(.body2_M)
                    .foregroundStyle(.black)
                Spacer()
                Text("보기")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .navigationTitle("설정")
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
