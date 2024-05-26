//
//  NoticeView.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import SwiftUI

import ComposableArchitecture

struct NoticeView: View {
    
    private let store: StoreOf<NoticeFeature>
    
    init(store: StoreOf<NoticeFeature>) {
        self.store = store
    }
    
    var body: some View {
        Text("공지사항")
    }
}
