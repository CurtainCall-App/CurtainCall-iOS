//
//  NoticeDetailView.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct NoticeDetailView: View {
    
    private let store: StoreOf<NoticeDetailFeature>
    
    @Environment(\.dismiss) var dismiss
    
    init(store: StoreOf<NoticeDetailFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            headerView
            ScrollView {
                Text(store.noticeDetailInfo?.content ?? "")
                    .font(.body2_M)
                    .foregroundStyle(Color.gray2)
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("공지사항")
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
        .onAppear {
            store.send(.fetchNoticeDetail)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Text(store.noticeDetailInfo?.title ?? "")
                    .font(.subTitle4)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                Spacer()
            }
            HStack {
                Text(convertAPIDateStringToString(dateString: store.noticeDetailInfo?.createdAt ?? ""))
                    .font(.body3)
                    .foregroundStyle(Color.gray5)
                    .padding(.top, 8)
                Spacer()
            }
            .padding(.bottom, 20)
            Color.gray8.frame(height: 1)
        }
        .padding(.vertical, 20)

    }
}

extension NoticeDetailView {
    private func convertAPIDateStringToString(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let convertFormaater = DateFormatter()
        convertFormaater.dateFormat = "yyyy.MM.dd"
        convertFormaater.locale = Locale(identifier: "ko-KR")
        if let date = formatter.date(from: dateString) {
            return convertFormaater.string(from: date)
        } else {
            return "날짜 정보 없음"
        }
    }
}
