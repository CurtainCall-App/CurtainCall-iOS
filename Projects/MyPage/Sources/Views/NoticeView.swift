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
        notice
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
    
    var notice: some View {
        VStack {
            
        }
    }
    
}
