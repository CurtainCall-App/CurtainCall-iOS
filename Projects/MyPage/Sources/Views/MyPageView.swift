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
    private let store: StoreOf<MyPageFeature>
    
    public init(store: StoreOf<MyPageFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    profileView
                    Color.gray9.frame(height: 10)
                    myActivityView
                    Color.gray9.frame(height: 10)
                    serviceView
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
            }
            HStack(spacing: 12) {
                Image(asset: CommonAsset.mypageMyReviewIcon)
                Text("내가 쓴 글")
            }
            HStack(spacing: 12) {
                Image(asset: CommonAsset.mypageMyHeartIcon)
                Text("좋아요한 작품 목록")
            }
            .padding(.bottom, 30)
        }
        .padding(.leading, 20)
    }
    
    private var serviceView: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("서비스")
                .font(.subTitle4)
                .foregroundStyle(.black)
                .padding(.top, 30)
            HStack {
                Text("공지사항")
                Spacer()
                Image(asset: CommonAsset.arrowRightIcon16px)
            }
            HStack(spacing: 12) {
                Text("자주 묻는 질문")
                Spacer()
                Image(asset: CommonAsset.arrowRightIcon16px)
            }
            .padding(.bottom, 30)
        }
        .padding(.leading, 20)
    }
    
    private var bottomView: some View {
        VStack {
            Text("커튼콜 고객센터")
                .font(.body4)
                .foregroundStyle(Color.gray4)
                .padding(.top, 30)
            Text("curtaincall.official2023@gmail.com")
                .font(.body3)
                .foregroundStyle(Color.gray5)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray7, lineWidth: 1)
                        .foregroundStyle(.clear)
                }
            Text("작품 정보 출처")
                .font(.body4)
                .foregroundStyle(Color.gray4)
            Text("(재)예술경영지원센터 공연예술통합전산망\n© 2023. Curtain Call all rights reserved.")
                .font(.body5)
                .foregroundStyle(Color.gray5)
                .padding(.bottom, 40)
        }
        .background(Color.gray9)
        .padding(.horizontal, 20)
        
    }
}
