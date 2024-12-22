//
//  LiveTalkView.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 8/10/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct LiveTalkView: View {
    @Bindable private var store: StoreOf<LiveTalkFeature>
    
    public init(store: StoreOf<LiveTalkFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("라이브톡")
    }
}
