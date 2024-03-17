//
//  MyPageView.swift
//  MyPage
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import ComposableArchitecture

public struct MyPageView: View {
    private let store: StoreOf<MyPageFeature>
    
    public init(store: StoreOf<MyPageFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("MyPage")
        }
    }
}
