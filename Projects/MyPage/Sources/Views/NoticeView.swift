//
//  NoticeView.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct NoticeView: View {
    
    private let store: StoreOf<NoticeFeature>
    
    @Environment(\.dismiss) var dismiss
    
    init(store: StoreOf<NoticeFeature>) {
        self.store = store
    }
    
    var body: some View {
        ScrollView {
            noticeView
                .onAppear {
                    store.send(.fetchNoticeList)
                }
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
        }
    }
    
    private var noticeView: some View {
        VStack(alignment: .leading) {
            ForEach(store.noticeList, id: \.self) { info in
                VStack(spacing: 0) {
                    HStack {
                        Text(info.title)
                            .font(.subTitle4)
                            .foregroundStyle(.black)
                            .lineLimit(1)
                        Spacer()
                        Image(asset: CommonAsset.arrowRightIcon16px)
                    }
                    HStack {
                        Text(convertAPIDateStringToString(dateString: info.createdAt))
                            .font(.body3)
                            .foregroundStyle(Color.gray5)
                            .padding(.top, 8)
                        Spacer()
                    }
                }
                .padding([.vertical, .horizontal], 20)
                Color.gray8.frame(height: 1)
                    .padding(.horizontal, 20)
            }
            Spacer()
        }
        .padding(.top, 20)
        
    }
    
}

extension NoticeView {
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
