//
//  MyPageView.swift
//  MyPage
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct MyPageView: View {
    private var store: StoreOf<MyPageFeature>
    
    public init(store: StoreOf<MyPageFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            ScrollView {
                VStack(alignment: .leading) {
                    profileView
                    Color.gray9.frame(height: 10)
                    myActivityView
                    Color.gray9.frame(height: 10)
                    serviceView
                    bottomView
                }
            }
        } destination: { store in
            switch store.state {
            case .notice:
                if let store = store.scope(state: \.notice, action: \.notice) {
                    NoticeView(store: store)
                }
            case .noticeDetail:
                if let store = store.scope(state: \.noticeDetail, action: \.noticeDetail) {
                    NoticeDetailView(store: store)
                }
            case .FAQ:
                if let store = store.scope(state: \.FAQ, action: \.FAQ) {
                    FAQView(store: store)
                }
            case .setting:
                if let store = store.scope(state: \.setting, action: \.setting) {
                    SettingView(store: store)
                }
             }
        }

        
    }
    
    private var profileView: some View {
        HStack(spacing: 14) {
            Image(asset: CommonAsset.mypageDefaultProfile)
            Text("커튼콜님")
                .font(.subTitle4)
                .foregroundStyle(.black)
            Spacer()
            Text("프로필 번경")
                .font(.body5)
                .foregroundStyle(Color.gray5)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gray5, lineWidth: 1)
                        .foregroundStyle(.clear)
                }
        }
        .padding(.horizontal, 20)
        .frame(height: 136)
    }
    
    private var myActivityView: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("나의 활동")
                .font(.subTitle4)
                .foregroundStyle(.black)
                .padding(.top, 30)
            HStack(spacing: 12) {
                Image(asset: CommonAsset.mypagePartymemeberIcon)
                Text("MY 파티원")
                    .font(.body2_M)
            }
            HStack(spacing: 12) {
                Image(asset: CommonAsset.mypageMyReviewIcon)
                Text("내가 쓴 글")
                    .font(.body2_M)
            }
            HStack(spacing: 12) {
                Image(asset: CommonAsset.mypageMyHeartIcon)
                Text("좋아요한 작품 목록")
                    .font(.body2_M)
            }
            .padding(.bottom, 30)
        }
        .padding(.leading, 20)
    }
    
    private var serviceView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("서비스")
                .font(.subTitle4)
                .foregroundStyle(.black)
                .padding(.top, 30)
            HStack {
                Text("설정")
                    .font(.body2_M)
                Spacer()
                Image(asset: CommonAsset.arrowRightIcon16px)
            }
            .frame(height: 51)
            .padding(.top, 15)
            .onTapGestureRectangle {
                store.send(.didTappedSettingView)
            }
            HStack {
                Text("공지사항")
                    .font(.body2_M)
                Spacer()
                Image(asset: CommonAsset.arrowRightIcon16px)
            }
            .frame(height: 51)
            .onTapGestureRectangle {
                store.send(.didTappedNoticeView)
            }
            HStack(spacing: 12) {
                Text("자주 묻는 질문")
                    .font(.body2_M)
                Spacer()
                Image(asset: CommonAsset.arrowRightIcon16px)
            }
            .frame(height: 51)
            .padding(.bottom, 30)
            .onTapGestureRectangle {
                store.send(.didTappedFAQView)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var bottomView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("커튼콜 고객센터")
                    .font(.body4)
                    .foregroundStyle(Color.gray4)
                Spacer()
            }
            .padding(.top, 30)
            HStack(spacing: 6) {
                Image(asset: CommonAsset.mypageMailIcon)
                    .padding(.leading, 12)
                Text("curtaincall.official2023@gmail.com")
                    .font(.body3)
                    .foregroundStyle(Color.gray5)
                    .padding(.vertical, 8)
                    
                Spacer()
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray7, lineWidth: 1)
                    .foregroundStyle(.clear)
            }
            .padding(.top, 8)
            
            HStack {
                Text("작품 정보 출처")
                    .font(.body4)
                    .foregroundStyle(Color.gray4)
                Spacer()
            }
            .padding(.top, 30)
            HStack {
                Text("(재)예술경영지원센터 공연예술통합전산망\n© 2023. Curtain Call all rights reserved.")
                    .font(.body5)
                    .foregroundStyle(Color.gray5)
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .background(Color.gray9)
        
    }
}
